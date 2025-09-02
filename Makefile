COMPILER 	= xelatex
TEXFILE		= _cv
SRCDIR  	= data
BUILDDIR 	= build
IMAGE   	= cv-latex
PDF   		= Smith_Schuyler_CV.pdf

cv: $(PWD)/$(PDF)
	mkdir -p $(BUILDDIR)
	docker run --rm \
		-v "$(PWD)/$(SRCDIR)":/data \
		-v "$(PWD)/$(BUILDDIR)":/$(BUILDDIR) \
		-w /data \
		$(IMAGE) \
		$(COMPILER) \
		-output-directory=/$(BUILDDIR) \
		$(TEXFILE).tex
	docker run --rm \
		-v "$(PWD)/$(SRCDIR)":/data \
		-v "$(PWD)/$(BUILDDIR)":/$(BUILDDIR) \
		-w /data \
		$(IMAGE) \
		biber \
		--input-directory /$(BUILDDIR) \
		--output-directory /$(BUILDDIR) \
		$(TEXFILE)
	docker run --rm \
		-v "$(PWD)/$(SRCDIR)":/data \
		-v "$(PWD)/$(BUILDDIR)":/$(BUILDDIR) \
		-w /data \
		$(IMAGE) \
		$(COMPILER) \
		-output-directory=/$(BUILDDIR) \
		$(TEXFILE).tex
	docker run --rm \
		-v "$(PWD)/$(SRCDIR)":/data \
		-v "$(PWD)/$(BUILDDIR)":/$(BUILDDIR) \
		-w /data \
		$(IMAGE) \
		$(COMPILER) \
		-output-directory=/$(BUILDDIR) \
		$(TEXFILE).tex
	cp $(BUILDDIR)/$(TEXFILE).pdf $(PWD)/$(PDF)

clean:
	rm -rf $(BUILDDIR)

.PHONY: cv clean
