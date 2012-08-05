PACKAGE=com.mbauman.betterbindings
PACKAGE_DIR=$(subst .,/,$(PACKAGE))

# Include all .java files in the package
SOURCES=$(wildcard *.java)
CLASSES=$(patsubst %.java,$(PACKAGE_DIR)/%.class,${SOURCES})

JARFILE=$(PACKAGE).jar

all: $(JARFILE)

${JARFILE}: ${CLASSES}
	jar cvf $@ com

$(PACKAGE_DIR)/%.class: %.java
	javac -d . $<
