rm(list=ls()) # start with a clean session

# instation package
require(phyloseq)
require(ggplot2)
require(reshape2)
require('ampvis')
require(RColorBrewer)
require(vegan)
require(dplyr)

set.seed(62) # for reproduciblity

####Loading Files####

setwd("~/Projects/Synced/Drive/Formation/phyloseq/Riz/") # this here we want to be

otutable <- import_biom(BIOMfilename = 'riz2.biom.txt', 
                        parseFunction = parse_taxonomy_greengenes)

otutable
# it is a phyloseq object with an OTU table and a Taxonony table

# we can access the 'OTU' / sample occurence table with the follwing command:
head(otu_table(otutable))

# and explore the data
colSums(otu_table(otutable)) # number of sequences per sample

barplot(sort(colSums(otu_table(otutable))),
        las=2, ylim = c(0, 100000), xlim = c(0, 30)) # 

sort(rowSums(otu_table(otutable)),decreasing = T)[1:10] # 

# we can access the taxonomical information of the different OTU with the follwing command:
head(tax_table(otutable))

# Import mapping file
mapping <- import_qiime_sample_data(mapfilename = 'riz_metadata.txt')

head(mapping)

# Define Group variable
colnames(mapping)
mapping$Group <- as.factor(paste(mapping$Field,mapping$Infection,sep = "_"))

# Check / Define levels
levels(sample_data(mapping)$Group)
                                                                     
# Manually check Taxa
head(tax_table(otutable))

# Manually define taxonomical ranks
colnames(tax_table(otutable)) = c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

# Merge map and otu table into once phyloseq object
phylo <- merge_phyloseq(otutable, mapping)

# Check
rank_names(phylo) # taxonimcal ranks
nsamples(phylo) # number of samples
ntaxa(phylo) # number of OTU
sample_variables(phylo) # metadata

# acess some inside objects
otu_table(phylo) # OTU table
head(tax_table(phylo))  # Taxonomical correspondance of OTU table

####  Preprocessing ####
# raw taxa distribution 
readsumsdf = data.frame(nreads = sort(taxa_sums(phylo), TRUE), sorted = 1:ntaxa(phylo), 
                        type = "OTU")
readsumsdf = rbind(readsumsdf, data.frame(nreads = sort(sample_sums(phylo), 
                                                        TRUE), sorted = 1:nsamples(phylo), type = "Samples"))

p = ggplot(readsumsdf, aes(x = sorted, y = nreads)) + geom_bar(stat = "identity")
p + ggtitle("Total number of reads before Preprocessing") + scale_y_log10() + facet_wrap(~type, 1, scales = "free")

# raw rarefaction curves

amp_rarecurve(phylo,
              step=1000,
              color="Group",
              label = F)

# Preprocessing
phylo = filter_taxa(phylo, function(x) sum(x > 10) > (1), TRUE) #Remove taxa not seen more than 10 in more than 1 (=2) samples

phylo_rare = rarefy_even_depth(phylo)

colSums(otu_table(phylo_rare))
plot(colSums(otu_table(phylo_rare)))

# Rarefaction curves (filtered)
amp_rarecurve(phylo_rare,
              step=100,
              color="Group",
              label = F)


# filtered OTU distribution 
readsumsdf = data.frame(nreads = sort(taxa_sums(phylo_rare), TRUE), sorted = 1:ntaxa(phylo_rare), type = "OTU")

readsumsdf = rbind(readsumsdf, data.frame(nreads = sort(sample_sums(phylo_rare), TRUE), sorted = 1:nsamples(phylo_rare), type = "Samples"))

p = ggplot(readsumsdf, aes(x = sorted, y = nreads)) + geom_bar(stat = "identity")

p + ggtitle("Total number of reads after preprocessing") + scale_y_log10() + facet_wrap(~type, 1, scales = "free")

# export filtere OTU table
write.csv(cbind(data.frame(otu_table(phylo_rare)),tax_table(phylo_rare)), file="filtered_otu_table.csv")

#### Define colors ####

display.brewer.all(n=10, exact.n=FALSE) # display color palets
summary(sample_data(phylo_rare)) # we have 5 groups
group_colors <- brewer.pal((length(unique(get_variable(phylo_rare, "Group")))),"Set2") # choose 5 colors
group_colors

#### alpha div ####

p <- plot_richness(phylo_rare, x="Group", color="Group", measures=c("Observed","Shannon","ACE"), nrow = 1)

print(p)

p$data # data to plot are stored in p

ggplot(p$data,aes(Infection,value,colour=Infection)) +
  facet_grid(variable ~ Infection, drop=T,scale="free",space="fixed") +
  geom_boxplot(outlier.colour = NA,alpha=1)

# More Complex
ggplot(p$data,aes(Group,value,colour=Infection,shape=Field)) +
  facet_grid(variable ~ Infection, drop=T,scale="free",space="fixed") +
  geom_boxplot(outlier.colour = NA,alpha=0.8, 
               position = position_dodge(width=0.9)) + 
  ylab("Diversity index")  + xlab(NULL) + theme_bw() +   
  scale_fill_manual(values=group_colors, name="Infection") +
  scale_color_manual(values=group_colors, name="Infection")

# Export the alpha div values

colnames(p$data)
rich.plus <- dcast(p$data,  X.SampleID + Field + Infection + Group ~ variable)
head(rich.plus)

write.csv(rich.plus, file="alpha_div.csv")

# Alpha-div Stats Control vs/ Treated

TukeyHSD_Observed <- TukeyHSD(aov(Observed ~ Infection, data =  rich.plus))
TukeyHSD_Observed_df <- data.frame(TukeyHSD_Observed$Infection)
TukeyHSD_Observed_df$measure = "Observed"
TukeyHSD_Observed_df$shapiro_test_pval = (shapiro.test(residuals(aov(Observed ~ Infection, data =  rich.plus))))$p.value

TukeyHSD_Shannon <- TukeyHSD(aov(Shannon ~ Infection, data =  rich.plus))
TukeyHSD_Shannon_df <- data.frame(TukeyHSD_Shannon$Infection)
TukeyHSD_Shannon_df$measure = "Shannon"
TukeyHSD_Shannon_df$shapiro_test_pval = (shapiro.test(residuals(aov(Shannon ~ Infection, data =  rich.plus))))$p.value

write.csv(cbind(TukeyHSD_Observed_df,TukeyHSD_Shannon_df), file="alpha_div_stats.csv")

#### taxa plot ####

# manual
colours <- c("#F0A3FF", "#0075DC", "#993F00","#4C005C","#2BCE48","#FFCC99",
             "#808080","#94FFB5","#8F7C00","#9DCC00","#C20088","#003380",
             "#FFA405","#FFA8BB","#426600","#FF0010","#5EF1F2","#00998F","#740AFF",
             "#990000","#FFFF00")

toplot=NULL
n=21 # top n Taxa

colnames(tax_table(phylo_rare))

toplot <- phylo_rare %>%
  tax_glom(taxrank = "Family") %>%                     # agglomerate at Family level
  transform_sample_counts(function(x) {x/sum(x)} ) #%>% # Transform to rel. abundance

write.csv(data.frame(merge(otu_table(toplot),tax_table(toplot),by.x = "row.names", by.y = "row.names"))
           , file="otu_table_Family.csv")

toplot2 <-  prune_taxa(names(sort(taxa_sums(toplot), TRUE)[1:n]),toplot) %>%
  subset_taxa(Family != "unknown family" & Family != "Multi-affiliation") %>% 
  psmelt()   

head(toplot2)

ggplot(toplot2, aes(x = Sample, y = Abundance, fill = Family)) + 
  geom_bar(stat = "identity")

ggplot(toplot2, aes(x = Sample, y = Abundance, fill = Family)) + 
  geom_bar(stat = "identity") +
  scale_fill_manual(values = colours)

# more complex
ggplot(toplot2, aes(x = Sample, y = Abundance, fill = Family)) + 
  facet_grid(. ~ Infection, drop=TRUE,scale="free",space="free_x") +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = colours) +
  theme_bw() +
  guides(fill=guide_legend(ncol=2)) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.x=element_text(angle=75,hjust=0,vjust=0)) +
  ylab(paste0("Relative Abundance (Top ",n," ) \n"))

ggplot(toplot2, aes(x = Sample, y = Abundance, fill = Family)) + 
  facet_grid(Kingdom ~ Infection + Field, drop=TRUE,scale="free",space="free_x") +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = colours) +
  theme_bw() +
  guides(fill=guide_legend(ncol=1)) +
  theme(axis.title.x = element_blank()) +
  theme(axis.text.x=element_text(angle=75,hjust=0,vjust=0)) +
  ylab(paste0("Relative Abundance (Top ",n," ) \n"))

#### beta diversity ####

# Compute dissimilarity

dist <- vegdist(as.data.frame(sqrt(t(otu_table(phylo_rare)))),binary=T, method = "bray") # including sqrt transformation

# PCoA
plot_ordination(phylo_rare, ordinate(phylo_rare,"PCoA",dist), color = "Infection", shape="Field" ,title = "PCoA sqrt Bray curtis", label= "X.SampleID" ) + 
  geom_point(aes(size=rich.plus$Observed)) +
  theme_bw() + scale_color_manual(values=group_colors, name="Group")

# NMDS
plot_ordination(phylo_rare, ordinate(phylo_rare,"NMDS",dist),
                color = "Infection", shape= "Field", 
                title = paste0("NMDS sqrt Bray curtis 2d stress = ", round((ordinate(phylo_rare,"NMDS",dist)$stress),2)))+
  geom_point(size = 4.5) +
  theme_bw() + scale_color_manual(values=group_colors, name="Group")


# PERMANOVA 

adonis(dist ~ get_variable(phylo_rare, "Infection")
         ,permutations = 1000)$aov.tab

adonis(dist ~ get_variable(phylo_rare, "Infection") + get_variable(phylo_rare, "Field")
         ,permutations = 1000)$aov.tab

adonis(dist ~ get_variable(phylo_rare, "Infection") * get_variable(phylo_rare, "Field")
       ,permutations = 1000)$aov.tab

adonis(dist ~ get_variable(phylo_rare, "Group")
       ,permutations = 1000)$aov.tab

# BETA-Disper plot and test
boxplot(betadisper(dist, get_variable(phylo_rare, "Infection")),las=2,col = group_colors, 
        main=paste0("Multivariate Dispersion Test Bray curtis "," pvalue = ", permutest( betadisper(dist, get_variable(phylo_rare, "Infection")))$tab$`Pr(>F)`[1]))

boxplot(betadisper(dist, get_variable(phylo_rare, "Field")),las=2,col = group_colors, 
        main=paste0("Multivariate Dispersion Test Bray curtis "," pvalue = ", permutest( betadisper(dist, get_variable(phylo_rare, "Field")))$tab$`Pr(>F)`[1]))

boxplot(betadisper(dist, get_variable(phylo_rare, "Group")),las=2,col = group_colors, 
        main=paste0("Multivariate Dispersion Test Bray curtis "," pvalue = ", permutest( betadisper(dist, get_variable(phylo_rare, "Group")))$tab$`Pr(>F)`[1]))

# ANOSIM
plot(anosim(dist, get_variable(phylo_rare, "Infection"))
     , main="ANOSIM  "
     ,las=2)

plot(anosim(dist, get_variable(phylo_rare, "Field"))
     , main="ANOSIM  "
     ,las=2, col = c("black",group_colors))

plot(anosim(dist, get_variable(phylo_rare, "Group"))
     , main="ANOSIM  "
     ,las=2, col = c("black",group_colors))


