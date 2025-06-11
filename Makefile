# # Minimal makefile for Sphinx documentation
# #

# # You can set these variables from the command line.
# SPHINXOPTS    =
# SPHINXBUILD   = sphinx-build
# SPHINXPROJ    = viser
# SOURCEDIR     = source
# BUILDDIR      = ./

# # Put it first so that "make" without argument is like "make help".
# help:
# 	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# .PHONY: help Makefile

# # Catch-all target: route all unknown targets to Sphinx using the new
# # "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
# %: Makefile
# 	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)


# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = dexmachina
SOURCEDIR     = source
BUILDDIR      = _temp_build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile clean html-root

# Clean target to remove build artifacts
clean:
	rm -rf _temp_build *.html _static _sources objects.inv .doctrees .buildinfo

# Custom target to build HTML directly to root
html-root:
	@$(SPHINXBUILD) -b html "$(SOURCEDIR)" . $(SPHINXOPTS) $(O)
	@echo "Build finished. The HTML pages are in the root directory."
	@touch .nojekyll

# Standard HTML build (for testing)
html:
	@$(SPHINXBUILD) -M html "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)