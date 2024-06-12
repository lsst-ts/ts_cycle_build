ARG cycle
ARG hub

FROM ${hub}/deploy-env:${cycle}

LABEL maintainer Sebastian Aranda <saranda@lsst.org>

WORKDIR /home/saluser/

ARG rubintv

RUN source /home/saluser/.setup_sal_env.sh && \
    pip install safir && \
    conda install -y -c lsstts \
    rubintv=${rubintv}

RUN git clone https://github.com/lsst-ts/rubintv

WORKDIR /home/saluser/rubintv

# Handle npm built assets
RUN git checkout v${rubintv}
RUN source /home/saluser/.setup_sal_env.sh && \
    npm install webpack && \
    npm run build

RUN cp -R /home/saluser/rubintv/assets /home/saluser/assets

WORKDIR /home/saluser/

LABEL rubintv=${rubintv}

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
