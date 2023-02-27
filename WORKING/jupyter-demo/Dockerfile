FROM jupyter/base-notebook:latest

WORKDIR /work

USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN git clone https://github.com/stackql/pystackql

COPY ./bin/stackql /bin/stackql
RUN chmod +x /bin/stackql

# RUN wget --no-verbose https://releases.stackql.io/stackql/latest/stackql_linux_amd64.zip && \
#     unzip stackql_linux_amd64.zip && \
#     mv stackql /bin/stackql && \
#     chmod +x /bin/stackql && \
#     rm stackql_linux_amd64.zip

#RUN git clone https://jeffreyaven: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@github.com/stackql/local-registry.git

COPY ./keys /keys
COPY ./notebooks/google.ipynb /work
COPY ./notebooks/okta.ipynb /work
COPY ./notebooks/github.ipynb /work
COPY ./notebooks/netlify.ipynb /work

RUN chmod 644 google.ipynb && \
    chmod 644 okta.ipynb && \
    chmod 644 github.ipynb && \
    chmod 644 netlify.ipynb && \
    chown jovyan:users google.ipynb && \
    chown jovyan:users okta.ipynb && \
    chown jovyan:users github.ipynb && \
    chown jovyan:users netlify.ipynb

ENV PYTHON_PACKAGES="\
    matplotlib \
    pandas \
	mplfinance \
" 

RUN pip install --upgrade pip \
    && pip install --no-cache-dir $PYTHON_PACKAGES