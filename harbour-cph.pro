PREFIX = harbour
NAME = cph

TARGET = $${PREFIX}-$${NAME}

CONFIG += sailfishapp_qml

DEFINES += APP_VERSION='\\"$$VERSION\\"'

OTHER_FILES += \
    rpm/harbour-cph.spec \
    qml/harbour-cph.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    translations/*.ts \
    harbour-cph.desktop \
    rpm/harbour-cph.changes \
    src/*.py


# Python Data
src.files = src/*
src.path = /usr/share/$${TARGET}/src

INSTALLS += src

# SAILFISHAPP_ICONS = 86x86

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-cph-pl.ts

