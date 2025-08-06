FROM golang:1.22.2-bookworm as builder

# 创建工作目录
RUN mkdir /data

# 设置工作目录
WORKDIR /data

# 复制代码
COPY . /data



# build
RUN cd /data && go build -o app

# slim
FROM debian:12.5-slim

# 项目配置环境变量
ENV GOENV prod_cn


# 创建工作目录
RUN mkdir /data

# 设置工作目录
WORKDIR /data

# 复制执行文件
COPY --from=builder /data/app /data



#
EXPOSE 3000
#
ENTRYPOINT ["./app"]
