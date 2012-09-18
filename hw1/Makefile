# Makefile for LaTeX files

# Original Makefile from http://www.math.psu.edu/elkin/math/497a/Makefile

# Please check http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile
# for new versions.

# Copyright (c) 2005,2006 (in order of appearance):
#	Matti Airas <Matti.Airas@hut.fi>
# 	Rainer Jung
#	Antoine Chambert-Loir
#	Timo Kiravuo

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions: 

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software. 

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

# $Id: Makefile,v 1.18 2006-06-19 10:58:11 mairas Exp $


LATEX	= latex -interaction=batchmode
BIBTEX	= bibtex
MAKEINDEX = makeindex
XDVI	= xdvi -gamma 4
DVIPS	= dvips
DVIPDF  = dvipdft
#MAKEDJVU= djvudigital --words
MAKEDJVU= pdf2djvu -q
DJVUVIEW= evince
L2H	= mk4ht xhmlatex 
GH	= evince
PDFVIEW = evince
CONVERT= convert
GZIP = gzip --best
#Colors
gray=\e[1;30m
red=\e[0;31m
RED=\e[1;31m
blue=\e[0;34m
BLUE=\e[1;34m
green=\e[0;32m
GREEN=\e[1;32m
cyan=\e[0;36m
CYAN=\e[1;36m
NC=\e[0m # No Color

RERUN = "(Rerun to get (cross-references|the bars) right)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"
MAKEIDX = "^[^%]*\\makeindex"
MPRINT = "^[^%]*print"
USETHUMBS = "^[^%]*thumbpdf"
FIGDIR = generated
LTITLE = LaTeX
DATE=$(shell date +%Y-%m-%d)

COPY = if test -r $(<:%.tex=%.toc); then cp $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); fi > /dev/null
RM = rm -f
QUIET= &>/dev/null
DISPLAYERROR= || ( echo -e "$(BLUE)====> $(RED)Errors encountered:$(NC)" && perl -0 -ne '$$now=0;$$previous=0;@matches=/(![^.]*[.]\s*\n(?:[^l].*\n)*(l[.][0-9]+.*)\n)/g;foreach $$text (@matches) { if ($$text =~ /^l[.][0-9]+.*$$/) { $$previous = $$text } else { $$text =~ /\n(l[.][0-9]+.*)/; $$now=$$1; if ( $$previous ne  $$now ) { print "\n$$text\n" } } }' $(<:%.tex=%.log) && false )

SRC	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
TRG	:= $(SRC:%.tex=%.dvi)
PSF	:= $(SRC:%.tex=%.ps)
PSZ	:= $(SRC:%.tex=%.ps.gz)
PDF	:= $(SRC:%.tex=%.pdf)
DJVU:= $(SRC:%.tex=%.djvu)

define run-latex
	$(COPY) $(QUIET);\
	echo -e "$(BLUE)====> $(green)Running $(NC)$(LTITLE)$(green) | $(red)First Run$(NC)";\
	$(LATEX) $< $(QUIET) $(DISPLAYERROR) ; runs=1; \
	if egrep $(MAKEIDX) $< $(QUIET);\
	then\
		echo -e "$(BLUE)====> $(green)Generating index$(NC)";\
		$(MAKEINDEX) $(<:%.tex=%) $(QUIET);\
		$(COPY) $(QUIET);\
		echo -e "$(BLUE)====> $(green)Running $(NC)$(LTITLE)$(green) | $(red)Including Index$(NC)";\
		$(LATEX) $< $(QUIET) $(DISPLAYERROR); let "runs=runs+1"; \
    fi;\
	bibrun=1;\
	while egrep -c $(RERUNBIB) $(<:%.tex=%.log) $(QUIET);\
	do\
		if [ "$$bibrun" -eq "1" ];\
		then\
			echo -e "$(BLUE)====> $(green)Parsing Bibliography$(NC)";\
			$(BIBTEX) $(<:%.tex=%) $(QUIET);\
		fi;\
		echo -e "$(BLUE)====> $(green)Running $(NC)$(LTITLE)$(green) | $(red)Applying bibliography (run $$bibrun)$(NC)";\
		$(COPY) $(QUIET);\
		$(LATEX) $< $(QUIET) $(DISPLAYERROR);\
		let "bibrun=bibrun+1";\
	done;\
	try=1;\
	while egrep -c $(RERUN) $(<:%.tex=%.log) $(QUIET);\
	do\
		echo -e "$(BLUE)====> $(green)Running $(NC)$(LTITLE)$(green) | $(red)Solving References (run $$try)$(NC)";\
		$(COPY) $(QUIET);\
		$(LATEX) $< $(QUIET) $(DISPLAYERROR);\
		let "try=try+1"; \
	done;\
	let "runs=runs + bibrun + try - 2";\
	if cmp -s $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak) $(QUIET);\
	then\
		true;\
	else \
		if test -r $(<:%.tex=%.toc.bak); \
		then \
			echo -e "$(BLUE)====> $(green)Running $(NC)$(LTITLE)$(green) | $(red)Solving References (run $$try)$(NC)";\
			$(LATEX) $< $(QUIET) $(DISPLAYERROR);\
			let "runs=runs+1";\
		fi;\
	fi;\
	$(RM) $(<:%.tex=%.toc.bak) $(QUIET);\
	echo -e "$(BLUE)====> $(blue)Finished $(NC)$(LTITLE)$(blue) in $(red)$$runs$(blue) runs$(NC)";
	echo -e "$(BLUE)====> ${blue}Undefined references and citations:"
	egrep -i "(Reference|Citation).*undefined" $(<:%.tex=%.log) && echo -n -e "$(NC)" || echo -e "$(green)None.$(NC)"; 
	echo -e "$(BLUE)====> $(blue)Dimensions:$(NC)";
	grep "dimension:" $*.log 2> /dev/null || echo -e "$(green)None.$(NC)";
	true;
endef

define get_dependencies
	deps=`perl -ne '($$_)=/^[^%]*\\\(?:include|input)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print "$$t.tex "}' $<`
endef

define get_dependent_dirs
	depdirs=`echo ". "; for dir in $$(for file in $$(perl -ne '($$_)=/^[^%]*\\\(?:include|input)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print "$$t.tex "}' $<);do echo $$(dirname $$file); done | sort -u); do echo -n $$dir; echo -n " "; done`
endef

define getbibs
	bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/;foreach $$b (@_) {print "$$b.bib "}' $< $$deps`
endef

define getepss
	epss=`perl -ne '@foo=/^[^%]*\\\(includegraphics|psfig|[a-zA-Z]+WallPaper\{[0-9]*\.?[0-9]*\})(\[.*?\])?\{(.*?)\}/g;if (defined($$foo[2])) { if ($$foo[2] =~ /.eps$$/) { print "$(FIGDIR)/$$foo[2] "; } else { print "$(FIGDIR)/$$foo[2].eps "; }}' $< $$deps`
endef

define getpdfs
	pdfs=`perl -ne '@foo=/^[^%]*\\\(includegraphics|[a-zA-Z]+WallPaper\{[0-9]*\.?[0-9]*\})(\[.*?\])?\{(.*?)\}/g;if (defined($$foo[2])) { if ($$foo[2] =~ /.pdf$$/) { print "$(FIGDIR)/$$foo[2] "; } else { print "$(FIGDIR)/$$foo[2].pdf "; }}' $< $$deps`
endef

define getfigdirs
	dirs="";\
	for file in $$epss $$pdfs;\
	do\
		dir=`dirname $$file`;\
		if (echo -e $$dirs | egrep -c $$dir) > /dev/null;\
		then\
			true;\
		else\
			dirs="$$dirs $$dir ";\
		fi\
	done
endef

define manconf
	mandeps=`if test -r $(basename $@).cnf ; then cat $(basename $@).cnf |tr -d '\n\r' ; fi`
endef


# $(DEP) $(EPSPICS) $(BIBFILE)
$(TRG)	: %.dvi : %.tex %.d
	@$(run-latex)

$(PSF)	: %.ps : %.dvi %.d
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(DVIPS) $< -o $@ $(QUIET)

$(PSZ) : %.ps.gz : %.ps
	@echo -e "$(BLUE)====> $(green)Compressing $(gray)$@$(NC)"
	@$(GZIP) -c $< > $@

$(PDF)	: LATEX = pdflatex -interaction=batchmode -file-line-error-style
$(PDF)	: LTITLE = PDFLaTeX
$(PDF)	: %.pdf : %.tex %.d
	@$(run-latex)
	@echo -e "$(BLUE)====> $(green)Optimizing $(gray)$@$(NC)"
	@(pdfopt $@ $@.pdf) $(QUIET)
	@mv $@.pdf $@ 

#$(PDF)  %.pdf : %.dvi
#	@echo -e "$(BLUE)====> $(green)Generating Portable Document File$(NC)"
#	@$(DVIPDF) -o $@ $<


$(DJVU): %.djvu : %.pdf
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@($(MAKEDJVU) -o $@ $< ) $(QUIET)


# image conversion rules
generated/%.eps	: 	%.png
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) -compress zip $< eps3:$@ 2> /dev/null 1> /dev/null

generated/%.eps	: 	%.tiff
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) -compress zip $< eps3:$@ 2> /dev/null 1> /dev/null

generated/%.eps	: 	%.jpg
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) -compress zip $< eps3:$@ 2> /dev/null 1> /dev/null

generated/%.eps	: 	%.bmp
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) -compress zip $< eps3:$@ 2> /dev/null 1> /dev/null

generated/%.eps	: 	%.gif
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) -compress zip $< eps3:$@ 2> /dev/null 1> /dev/null

generated/%.eps	:	%.pdf
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@pdftops -eps -level3 $< $@ 2> /dev/null 1> /dev/null


generated/%.eps	:	%.ps
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@ps2eps -l -q $<
	@mv $*.eps $@ 

generated/%.eps	:	%.eps
	@echo -e "$(BLUE)====> $(green)Copying $(gray)$@$(NC)"
	@cp $< $@

generated/%.eps	:	%.mp
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@mpost $<
	@mv $*.1 $@

generated/%.eps :	%.dia
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@dia --export=$@ --filter=eps $< 2> /dev/null 1> /dev/null


generated/%.pdf	:	%.pdf
	@echo -e "$(BLUE)====> $(green)Copying $(gray)$@$(NC)"
	@cp $< $@

generated/%.pdf :	%.eps
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@epstopdf --outfile=$@ $< 2> /dev/null 1> /dev/null

generated/%.pdf :	%.dia
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(green) | $(red)Step 1$(NC)"
	@dia --export=$(<:.dia=.eps) --filter=eps $< 2> /dev/null 1> /dev/null
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(green) | $(red)Step 2$(NC)"
	@epstopdf --outfile=$@ $(<:.dia=.eps) 2> /dev/null 1> /dev/null
	@-rm -rf $(<:.dia=.eps) &> /dev/null

generated/%.pdf :	%.ps
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@ps2pdf14 -dPDFSETTINGS=/prepress $< $@ 2> /dev/null 1> /dev/null

generated/%.pdf :	%.bmp
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) $< $@

generated/%.pdf :	%.png
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) $< $@

generated/%.pdf :	%.jpg
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) $< $@

generated/%.pdf :	%.tif
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) $< $@

generated/%.pdf :	%.tiff
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@$(CONVERT) $< $@

generated/%.pdf	:	%.mp
	@echo -e "$(BLUE)====> $(green)Generating $(gray)$@$(NC)"
	@mptopdf $< &> /dev/null
	@rm $*.1
	@mv $*-1.pdf $@


# This is a rule to generate a file of prerequisites for a given .tex file
%.d	: %.tex
	@echo -e "$(BLUE)====> $(green)Determining dependencies$(NC)" ;\
	$(get_dependencies) ; echo -e $$deps ; \
	$(getbibs) ; echo -e $$bibs ; \
	$(getepss) ;\
	$(getpdfs) ;\
	$(getfigdirs) ;\
	$(get_dependent_dirs) ;\
	$(manconf) ;\
	echo -e "$*.dvi $*.pdf $@ : $< $$deps $$bibs $$mandeps $(EXTRAS)" > $@ ; echo "" >> $@ ; \
	echo -e "$*.dvi : $$dirs $$epss" >> $@ ; echo "" >> $@ ; \
	echo -e "$*.pdf : $$dirs $$pdfs" >> $@ ; echo "" >> $@ ; \
	echo -e "DEPDIRS=$$depdirs" >> $@ ; echo "" >> $@ ; \
	if [[ $$dirs != "" ]]; then\
		echo -e "$$dirs	:" >> $@ ;\
		echo -e "	@echo \"$(BLUE)====> $(green)Creating $(gray)\$$@$(NC)\"" >> $@ ;\
		echo -e "	@mkdir -p \$$@" >> $@ ;\
	fi


.PHONY	: all show clean ps pdf html showps showpdf tidy verytidy clean-images pristine backup backupdir

all 	: $(TRG)

default :
	echo "$(blue)done.$(NC)"

view	: showpdf
show	: showpdf

viewdjvu: showdjvu
showdjvu: djvu
	@for i in $(DJVU) ; do \
		echo -e "$(BLUE)====> $(green)Viewing $(gray)$<: $$i$(NC)"; \
		$(DJVUVIEW) $$i; \
	done

viewdvi : showdvi
showdvi	: $(TRG)
	@for i in $(TRG) ; do \
		echo -e "$(BLUE)====> $(green)Viewing $(gray)$<: $$i$(NC)"; \
		$(XDVI) $$i; \
	done

viewps	: showps
showps	: ps
	@for i in $(PSF) ; do \
		echo -e "$(BLUE)====> $(green)Viewing $(gray)$<: $$i$(NC)"; \
		$(GH) $$i; \
	done

viewpdf	: showpdf
showpdf	: pdf
	@for i in $(PDF) ; do \
		echo -e "$(BLUE)====> $(green)Viewing $(gray)$<: $$i$(NC)"; \
		$(PDFVIEW) $$i; \
	done


psgz: $(PSZ)

postscript: ps
ps	: $(PSF) 

pdf	: $(PDF)

djvu: pdf $(DJVU)

backupdir:
	@ls backup > /dev/null || echo -e "$(BLUE)====> $(green)Creating Backup Directory$(NC)"
	@mkdir backup || true

backup: clean backupdir
	@echo -e "$(BLUE)====> $(green)Backing up project$(NC)"
	@export NUM=`ls backup/ | grep backup.tar.bz2 | wc -l` && tar jcvf ` echo -e "backup/backup.tar.bz2."$$NUM` `find ./ -not -type d -a -not -regex .*backup.* -a -not -regex .*svn.* | tail -n +2`


# TODO: This probably needs fixing
html	: $(DEP) $(EPSPICS)
	  @$(L2H) $(SRC) $(QUIET)

refresh:
	rm -rf *.d

tidy	:
	@echo -e "$(BLUE)====> $(green)Cleaning up temporary files$(NC)"
	@-rm -f $(TRG:%.dvi=%.bbl) $(TRG:%.dvi=%.blg) $(TRG:%.dvi=%.log) $(TRG:%.dvi=%.out) $(TRG:%.dvi=%.idx) $(TRG:%.dvi=%.ilg) $(TRG:%.dvi=%.ind) $(TRG:%.dvi=%.toc) $(TRG:%.dvi=%.d) *.mpx *.mp.keep *mp.mpo *-temp-mpgraph.mp mpgraph.mp

clean-images:
	@echo -e "$(BLUE)====> $(green)Cleaning up generated images$(NC)"
	@-rm -rf $(FIGDIR)

verytidy	: tidy clean-images
	@echo -e "$(BLUE)====> $(green)Cleaning up intermediate files$(NC)"
	@for dir in $(DEPDIRS); do cd $$dir && rm -f *.log *.aux *.dvi *.bbl *.blg *.ilg *.toc *.lof *.lot *.lol *.idx *.ind *.ps  *~ && cd - > /dev/null; done

clean:	verytidy
	@echo -e "$(BLUE)====> $(green)Cleaning up output files$(NC)"
	@-rm -f $(TRG) $(PSF) $(PSZ) $(PDF) $(DJVU)

pristine: clean
	@echo -e "$(BLUE)====> $(green)Removing backups$(NC)"
	@-rm -rf backup

include $(SRC:.tex=.d)
