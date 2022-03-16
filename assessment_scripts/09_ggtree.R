#trees for bins
library(tidyverse)
library(ggtree)
library(treeio)
library(ggplot2)
library(ape)
library(patchwork)


#import

MS_gtdb <- read.newick("Masso_5FC.consensus_round2.gtbdk.bac120.classify.tree")

#re-scale branch lengths for visability by factor of 10
MS_gtdb$edge.length <- MS_gtdb$edge.length*10

#our bin info from anvio
bin_names <- read.delim("mag.txt")

#bin names
bin_names$Anvio_BinID 

#subset to only small portions of tree that have our bins 
MS_gtdb_Bin_33_1_contigs <- tree_subset(MS_gtdb, "Bin_33_1-contigs", levels_back = 3)
MS_gtdb_Bin_34_12_contigs <- tree_subset(MS_gtdb, "Bin_34_12-contigs", levels_back = 5)
MS_gtdb_ps_1_contigs <- tree_subset(MS_gtdb, "ps_1-contigs", levels_back = 4)
MS_gtdb_Bin_33_2_contigs <- tree_subset(MS_gtdb, "Bin_33_2-contigs", levels_back = 4)

#less complete
MS_gtdb_Bin_34_14_1_contigs <- tree_subset(MS_gtdb, "Bin_34_14_1-contigs", levels_back = 4)
MS_gtdb_erw_contigs <- tree_subset(MS_gtdb, "erw-contigs", levels_back = 4)


ggtree(MS_gtdb_Bin_33_1_contigs, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(fontface = "bold.italic", size = 5, offset = 0.001) +
  xlim(0,1) + geom_nodelab(aes(label=node))

ggtree(MS_gtdb_Bin_34_12_contigs, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(fontface = "bold.italic", size = 5, offset = 0.001) +
  xlim(0,1) 

ggtree(MS_gtdb_ps_1_contigs, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(fontface = "bold.italic", size = 5, offset = 0.001) +
  xlim(0,1) 

ggtree(MS_gtdb_Bin_33_2_contigs, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(fontface = "bold.italic", size = 5, offset = 0.001) +
  xlim(0,1) 


ggtree(MS_gtdb_Bin_34_14_1_contigs, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(fontface = "bold.italic", size = 5, offset = 0.001) +
  xlim(0,1) 


ggtree(MS_gtdb_erw_contigs, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(fontface = "bold.italic", size = 5, offset = 0.001) +
  xlim(0,1) 


#download taxa key from gtdb 
#https://data.gtdb.ecogenomic.org/releases/latest/
taxonomy.bac <- read.delim("bac120_taxonomy.tsv", header= FALSE, col.names = c("label", "name"))

taxonomy.bac <- taxonomy.bac %>%
  separate(name, c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species"), sep = ";") %>%
  mutate(Taxonomy = str_replace(Species, "s__", ""))

taxonomy.bac$Taxonomy <- paste(taxonomy.bac$Taxonomy, " (", taxonomy.bac$label, ")", sep="")
taxonomy.bac$Source <- "ref"

#combine our data with taxononmy 

tree.meta.ms <- full_join(taxonomy.bac, bin_names)


#get taxa from each tree
MS_gtdb_Bin_33_1_contigs_subset_taxa <- MS_gtdb_Bin_33_1_contigs$tip.label 
MS_gtdb_Bin_34_12_contigs_subset_taxa <- MS_gtdb_Bin_34_12_contigs$tip.label
MS_gtdb_ps_1_contigs_subset_taxa <- MS_gtdb_ps_1_contigs$tip.label
MS_gtdb_Bin_33_2_contigs_subset_taxa <- MS_gtdb_Bin_33_2_contigs$tip.label
MS_gtdb_Bin_34_14_1_contigs_subset_taxa <- MS_gtdb_Bin_34_14_1_contigs$tip.label
MS_gtdb_erw_contigs_subset_taxa <- MS_gtdb_erw_contigs$tip.label

#now subset metadata
MS_gtdb_Bin_33_1_contigs_subset_taxa_meta <- tree.meta.ms %>% filter(label%in%MS_gtdb_Bin_33_1_contigs_subset_taxa)
MS_gtdb_Bin_34_12_contigs_subset_taxa_meta <- tree.meta.ms %>% filter(label%in%MS_gtdb_Bin_34_12_contigs_subset_taxa)
MS_gtdb_ps_1_contigs_subset_taxa_meta <- tree.meta.ms %>% filter(label%in%MS_gtdb_ps_1_contigs_subset_taxa)
MS_gtdb_Bin_33_2_contigs_subset_taxa_meta <- tree.meta.ms %>% filter(label%in%MS_gtdb_Bin_33_2_contigs_subset_taxa)
MS_gtdb_Bin_34_14_1_contigs_subset_taxa_meta <- tree.meta.ms %>% filter(label%in%MS_gtdb_Bin_34_14_1_contigs_subset_taxa)
MS_gtdb_erw_contigs_subset_taxa_meta <- tree.meta.ms %>% filter(label%in%MS_gtdb_erw_contigs_subset_taxa)

#Join metadata with the tree
MS_gtdb_Bin_33_1_contigs_tree <-full_join(MS_gtdb_Bin_33_1_contigs, MS_gtdb_Bin_33_1_contigs_subset_taxa_meta, by = "label")
MS_gtdb_Bin_34_12_contigs_tree <-full_join(MS_gtdb_Bin_34_12_contigs, MS_gtdb_Bin_34_12_contigs_subset_taxa_meta, by = "label")
MS_gtdb_ps_1_contigs_tree <-full_join(MS_gtdb_ps_1_contigs, MS_gtdb_ps_1_contigs_subset_taxa_meta, by = "label")
MS_gtdb_Bin_33_2_contigs_tree <-full_join(MS_gtdb_Bin_33_2_contigs, MS_gtdb_Bin_33_2_contigs_subset_taxa_meta, by = "label")
MS_gtdb_Bin_34_14_1_contigs_tree <-full_join(MS_gtdb_Bin_34_14_1_contigs, MS_gtdb_Bin_34_14_1_contigs_subset_taxa_meta, by = "label")
MS_gtdb_erw_contigs_tree <-full_join(MS_gtdb_erw_contigs, MS_gtdb_erw_contigs_subset_taxa_meta, by = "label")


#Bin_33_1
MS_gtdb_Bin_33_1_contigs_tree.plot <- ggtree(MS_gtdb_Bin_33_1_contigs_tree, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(aes(label = Taxonomy, color = Source),fontface = "bold.italic", size = 3, offset = 0.001) +
  xlim(0,3) + 
  scale_color_manual(values =c(study = "#EF7F4FFF", ref = "#000000")) +
  theme(legend.position = "none") 


#Bin_34_1
MS_gtdb_Bin_34_12_contigs_tree.plot <- ggtree(MS_gtdb_Bin_34_12_contigs_tree, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(aes(label = Taxonomy, color = Source),fontface = "bold.italic", size = 3, offset = 0.001) +
  xlim(0,3) + 
  scale_color_manual(values =c(study = "#EF7F4FFF", ref = "#000000")) +
  theme(legend.position = "none")


#MS_gtdb_ps_1_contigs_tree
MS_gtdb_ps_1_contigs_tree.plot <- ggtree(MS_gtdb_ps_1_contigs_tree, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(aes(label = Taxonomy, color = Source),fontface = "bold.italic", size = 3, offset = 0.001) +
  xlim(0,3) + 
  scale_color_manual(values =c(study = "#EF7F4FFF", ref = "#000000")) +
  theme(legend.position = "none") 



#MS_gtdb_Bin_33_2_contigs_tree
MS_gtdb_Bin_33_2_contigs_tree.plot <- ggtree(MS_gtdb_Bin_33_2_contigs_tree, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(aes(label = Taxonomy, color = Source),fontface = "bold.italic", size = 3, offset = 0.001) +
  xlim(0,3) + 
  scale_color_manual(values =c(study = "#EF7F4FFF", ref = "#000000")) +
  theme(legend.position = "none") 


#MS_gtdb_Bin_34_14_1_contigs_tree
MS_gtdb_Bin_34_14_1_contigs_tree.plot <- ggtree(MS_gtdb_Bin_34_14_1_contigs_tree, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(aes(label = Taxonomy, color = Source),fontface = "bold.italic", size = 3, offset = 0.001) +
  xlim(0,3) + 
  scale_color_manual(values =c(study = "#EF7F4FFF", ref = "#000000")) +
  theme(legend.position = "none") 


#MS_gtdb_erw_contigs_tree
MS_gtdb_erw_contigs_tree.plot <- ggtree(MS_gtdb_erw_contigs_tree, color = "black", size = 1.5, linetype = 1) + 
  geom_tiplab(aes(label = Taxonomy, color = Source),fontface = "bold.italic", size = 3, offset = 0.001) +
  xlim(0,3) + 
  scale_color_manual(values =c(study = "#EF7F4FFF", ref = "#000000")) +
  theme(legend.position = "none") 


MS_gtdb_Bin_33_1_contigs_tree.plot.col <-  MS_gtdb_Bin_33_1_contigs_tree.plot %>% collapse(56)
MS_gtdb_Bin_33_1_contigs_tree.plot.col <- MS_gtdb_Bin_33_1_contigs_tree.plot.col + geom_cladelabel(node = 56, label = "Chryseobacterium spp. (collapsed)", fontface = "bold.italic", color = "#000000", fontsize = 3)

(MS_gtdb_Bin_33_1_contigs_tree.plot.col +MS_gtdb_Bin_34_12_contigs_tree.plot + MS_gtdb_ps_1_contigs_tree.plot) / (MS_gtdb_Bin_33_2_contigs_tree.plot + MS_gtdb_Bin_34_14_1_contigs_tree.plot + MS_gtdb_erw_contigs_tree.plot)  + plot_annotation(tag_levels = "A")

ggsave(filename = 'MS_tree.png', plot = last_plot(), device = 'png', width = 13, height = 6, dpi = 300)

(MS_gtdb_Bin_33_1_contigs_tree.plot.col +MS_gtdb_Bin_34_12_contigs_tree.plot) / ( MS_gtdb_ps_1_contigs_tree.plot + MS_gtdb_Bin_33_2_contigs_tree.plot )  + plot_annotation(tag_levels = "A")

ggsave(filename = 'MS_tree_sub.png', plot = last_plot(), device = 'png', width = 9, height = 6, dpi = 300)


