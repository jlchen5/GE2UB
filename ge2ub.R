# 加载必要的包
library(ggplot2)
library(limma)
library(caret)

# 读取数据
expr_data <- read.csv("GSE76005_expression.csv", row.names = 1)
ub_data <- read.csv("GSE76005_ubiquitination.csv", row.names = 1)

# 数据预处理
# 筛选出有意义的基因
gene_filter <- rowSums(expr_data) > quantile(rowSums(expr_data), 0.1)
expr_data <- expr_data[gene_filter,]
ub_data <- ub_data[gene_filter,]

# 数据标准化
expr_data <- log2(expr_data + 1)
expr_data <- scale(expr_data)

# 将蛋白质泛素化数据转化为分类变量
ub_data[ub_data > 0] <- 1
ub_data[ub_data == 0] <- 0

# 将数据划分为训练集和测试集
set.seed(1234)
trainIndex <- createDataPartition(ub_data$Sample_Group, p = 0.8, list = FALSE)
train_data <- expr_data[trainIndex,]
train_labels <- ub_data[trainIndex,]
test_data <- expr_data[-trainIndex,]
test_labels <- ub_data[-trainIndex,]

######### 使用逻辑回归算法来构建预测模型
# 训练模型
set.seed(1234)
fitControl <- trainControl(method = "cv", number = 10)
model <- train(x = train_data, y = train_labels$Sample_Group, method = "glm", family = "binomial", trControl = fitControl)

# 输出模型性能
print(model)

# 用测试数据进行预测
predictions <- predict(model, newdata = test_data)

# 计算ROC曲线和AUC
library(pROC)
roc <- roc(test_labels$Sample_Group, predictions)
auc <- auc(roc)

# 绘制ROC曲线
plot(roc, main = "ROC Curve for Ubiquitination Prediction", print.auc = TRUE, legacy.axes = TRUE, grid = TRUE)

