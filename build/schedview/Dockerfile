ARG cycle
ARG hub

FROM ${hub}/scheduler:${cycle}

ARG schedview
ARG rubin_sim

RUN git clone https://github.com/lsst/schedview.git

WORKDIR /home/saluser/schedview

RUN /home/saluser/.checkout_repo.sh ${schedview}

RUN source /home/saluser/.setup_sal_env.sh && \
    mamba install -y bokeh pytest-flake8 pytest-black selenium firefox geckodriver build

RUN source /home/saluser/.setup_sal_env.sh && \
    python -m pip install --no-deps --ignore-installed .

COPY startup.sh /home/saluser/.startup.sh
USER root
RUN chown saluser:saluser /home/saluser/.startup.sh && \
    chmod a+x /home/saluser/.startup.sh
USER saluser
