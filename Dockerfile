############################################################
# Dockerfile to build OhMyZsh container images
# Based on Latest CentOS
# Added aws cli for my own use
############################################################

# Set the base image to CentOS
FROM centos

ENV HOME /root
RUN yum update -y && yum --nogpg install -y zsh git tmux

################## BEGIN INSTALLATION ######################
RUN git clone https://github.com/bwithem/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh
RUN sed -i -E "s/^plugins=\((.*)\)$/plugins=(\1 tmux)/" ~/.zshrc

### AWS CLI tid bits
WORKDIR /tmp
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py
RUN pip install awscli --upgrade --user && echo 'PATH=~/.local/bin:$PATH' >> /root/.zshrc

WORKDIR /root
ADD creds /root/.aws
CMD ["zsh"]
