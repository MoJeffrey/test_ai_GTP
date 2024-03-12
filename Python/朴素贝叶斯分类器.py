from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
import pandas as pd
# 准备数据


# 从CSV文件加载数据
df = pd.read_csv('TrainingSet.csv')
texts = df['text'].tolist()
labels = df['label'].tolist()

# 创建分类器
model = make_pipeline(CountVectorizer(), MultinomialNB())

# 训练模型
model.fit(texts, labels)

# 进行预测
new_text = "addressLine3"
predicted_label = model.predict([new_text])
print(predicted_label)

### 向量数据持久化
### 强化学习
