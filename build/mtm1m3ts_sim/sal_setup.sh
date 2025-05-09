# Configuration file to setup SAL environment. Default config assumes
# ts_opensplice is available in the same directory as ts_sal. You don't need to
# edit this file for the default config described in README.md.
#
# If needed, please change the LSST_SDK_INSTALL and OSPL_HOME to the actual
# locations before running the script.

BS_DIRNAME=$(dirname $BASH_SOURCE)
if [ $BS_DIRNAME = "." ]; then
  export LSST_SDK_INSTALL=${LSST_SDK_INSTALL:=$(pwd)}
else
  export LSST_SDK_INSTALL=${LSST_SDK_INSTALL:=$(pwd)/${BS_DIRNAME}}
fi


echo "LSST_SDK_INSTALL $LSST_SDK_INSTALL"

export SAL_HOME=$LSST_SDK_INSTALL/lsstsal
export SAL_WORK_DIR=$LSST_SDK_INSTALL/test

export SAL_CPPFLAGS=-m64
source $SAL_HOME/salenv.sh

if [ -z "$JAVA_HOME" ]; then
  export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
fi

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${SAL_HOME}/lib
export PATH=$JAVA_HOME/bin:${LSST_SDK_INSTALL}/bin:${PATH}

export SAL_IDL_DIR=${SAL_WORK_DIR}/idl-templates/validated/sal

export LSST_KAFKA_IP=`ip route get 1 | awk '{print $7;exit}'`
export LSST_KAFKA_SCHEMA_REGISTRY=${LSST_SCHEMA_REGISTRY_URL}
export LSST_KAFKA_HOST=${LSST_KAFKA_BROKER_ADDR%:*}
export LSST_KAFKA_BROKER_PORT=${LSST_KAFKA_BROKER_ADDR##*:}
export LSST_KAFKA_LOCAL_SCHEMAS=${LSST_SDK_INSTALL}
export LSST_KAFKA_PREFIX=${LSST_TOPIC_SUBNAME}
export LSST_KAFKA_SECURITY_PROTOCOL=SASL_PLAINTEXT
export LSST_KAFKA_SECURITY_MECHANISM=SCRAM-SHA-512
export OSPL_RELEASE=0.0.0

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${SAL_WORK_DIR}/lib:${LSST_SDK_INSTALL}/lib:/opt/lsst/ts_sal/lib
export TS_SAL_DIR=$LSST_SDK_INSTALL
export TS_XML_DIR=$LSST_SDK_INSTALL/../ts_xml
export AVRO_RELEASE=`$SAL_DIR/avro_release.tcl`
export AVRO_HOME=$SAL_HOME/lib
export AVRO_INCL=$SAL_HOME/include/avro
export AVRO_PREFIX=lsst.sal
export AVRO_CLASSPATH=lsst/sal

mkdir -p $LSST_SDK_INSTALL/lsstsal/lib
pushd $LSST_SDK_INSTALL
sal_version=`git describe --tags --dirty`
popd
export SAL_VERSION=$sal_version
echo "LSST middleware toolset environment "$sal_version" (Kafka) is configured."
echo "LSST_SDK_INSTALL=$LSST_SDK_INSTALL"
