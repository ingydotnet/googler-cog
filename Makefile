.PHONY: default all clean pull 

ABSPATH=perl -MCwd -e "print Cwd::abs_path shift"
SRC_DIR=$(shell $(ABSPATH) ..)
COG=$(SRC_DIR)/cog-pm/bin/cog
COGLIB=$(SRC_DIR)/cog-pm/lib
GOOGLERLIB=$(SRC_DIR)/googler-pm/lib

PULL=git pull origin master

export PERL5LIB=$(COGLIB):$(GOOGLERLIB)

up:
	$(PERL) $(COG) update
	$(PERL) $(COG) make
	PERL5LIB=$(PERL5LIB) $(PERL) $(COG) start -s Starman

clean:
	rm -rf \
	    cog/cache/ \
	    cog/store/ \
	    cog/static/ \
	    cog/template/

pull: $(COGLIB) $(GOOGLERLIB)
	$(PULL)
	(cd $(COGLIB);$(PULL))
	(cd $(GOOGLERLIB);$(PULL))

$(COGLIB):
	(cd $(SRC_DIR); git clone git://github.com/ingydotnet/cog-pm.git)

$(GOOGLERLIB):
	(cd $(SRC_DIR); git clone git://github.com/ingydotnet/googler-pm.git)

perl5lib:
	@echo export PERL5LIB=$(PERL5LIB)
