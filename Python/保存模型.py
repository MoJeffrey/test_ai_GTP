import joblib
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline

# 准备数据
texts = ["real_name", "mingzi", "address_info", "addressLine1", "customerName", "dizi"]
labels = ["name", "name", "address", "address", 'name', "address"]

# 创建分类器
model = make_pipeline(CountVectorizer(), MultinomialNB())

# 训练模型
model.fit(texts, labels)

# 进行预测
new_text = "home_address"
predicted_label = model.predict([new_text])
print(predicted_label)

# 保持
joblib.dump(model, 'pipeline_model.joblib')
