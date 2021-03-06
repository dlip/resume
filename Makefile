OUTDIR=dist

all: pdf html txt md

$(OUTDIR): ; mkdir $(OUTDIR)

pdf: $(OUTDIR)/resume.pdf
$(OUTDIR)/resume.pdf: $(OUTDIR) resume.yml resume.pandoc.tex ; pandoc --template resume.pandoc.tex --pdf-engine=xelatex -o $(OUTDIR)/resume.pdf resume.yml

html: $(OUTDIR)/index.html
$(OUTDIR)/index.html: $(OUTDIR) resume.yml resume.pandoc.html ; pandoc --template resume.pandoc.html --self-contained --css resume.css -o $(OUTDIR)/index.html resume.yml

txt: $(OUTDIR)/resume.txt
$(OUTDIR)/resume.txt: $(OUTDIR) resume.yml resume.pandoc.plain ; pandoc -t plain --template resume.pandoc.plain -o $(OUTDIR)/resume.txt resume.yml

md: $(OUTDIR)/resume.md
$(OUTDIR)/resume.md: $(OUTDIR) resume.yml resume.pandoc.markdown ; pandoc -t markdown  --template resume.pandoc.markdown -o $(OUTDIR)/resume.md resume.yml

publish: ; yarn run gh-pages

linkedin-import: ; yarn run linkedin-import

clean: ; rm -rf $(OUTDIR)