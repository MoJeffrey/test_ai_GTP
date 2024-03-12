from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier

# 从CSV文件加载数据
df = pd.read_csv('TrainingSet.csv')
texts = df['text'].tolist()
labels = df['label'].tolist()

# 创建KNN分类器并进行训练
# 创建并训练KNN分类器
vectorizer = CountVectorizer()
X_train_vectorized = vectorizer.fit_transform(texts)

knn_classifier = KNeighborsClassifier(n_neighbors=2)
knn_classifier.fit(X_train_vectorized, labels)

# 进行预测
new_text = ["addressLine2"]
new_text_vectorized = vectorizer.transform(new_text)
predicted_label = knn_classifier.predict(new_text_vectorized)
print(predicted_label)

### 向量数据持久化
### 强化学习
