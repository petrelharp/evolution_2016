.PHONY : clean

LATEXJUNK =  *.aux *.log *.nav *.out *.snm *.toc

FILESDIR = files

evolution-jun-2016.pdf : files/resistance-approx-right.pdf files/lineages-hitting-time-coal.pdf files/lineages-hitting-time-divergence.pdf

clean : 
	-rm -f $(LATEXJUNK)

%.pdf : %.tex
	while ( pdflatex $<;  grep -q "Rerun to get" $*.log ) do true ; done

## coal-hitting-time-diagram

$(FILESDIR)/coal-hitting-time-diagram-tmrca.pdf : $(FILESDIR)/coal-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< tmrca >$@

$(FILESDIR)/coal-hitting-time-diagram-tmrca2.pdf : $(FILESDIR)/coal-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< tmrca coal2 coal3  >$@

$(FILESDIR)/coal-hitting-time-diagram-divergence.pdf : $(FILESDIR)/coal-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< tmrca coal2 coal3 mutations divergence >$@

$(FILESDIR)/coal-hitting-time-diagram-hitting.pdf : $(FILESDIR)/coal-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< tmrca hitting >$@

## lineages-hitting-time-diagram

$(FILESDIR)/lineages-hitting-time-onelineage.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 >$@

$(FILESDIR)/lineages-hitting-time-coal.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 coalescence tmrca_label >$@

$(FILESDIR)/lineages-hitting-time-coal-decomp.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 coalescence tmrca_label other_labels >$@

$(FILESDIR)/lineages-hitting-time-divergence.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 coalescence tmrca_label divergence diverge_labels >$@

$(FILESDIR)/lineages-hitting-time-divergence-decomp.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 coalescence tmrca_label other_labels divergence decomp_labels >$@

$(FILESDIR)/lineages-hitting-time-divergence-notation.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 coalescence tmrca_label other_labels divergence notation_label >$@

$(FILESDIR)/lineages-hitting-time-resistance-coal.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< map lineage1 coalescence tmrca_label other_labels resistance_right >$@

$(FILESDIR)/lineages-hitting-time-resistance-divergence.pdf : $(FILESDIR)/lineages-hitting-time-diagram.ink.svg
	export-layers-svg.sh $< resistance divergence notation_label >$@

###

%.pdf : %.ink.svg
	inkscape --without-gui --export-pdf=$@ $<
