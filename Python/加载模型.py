import joblib

# 加载模型
loaded_model = joblib.load('pipeline_model.joblib')

# 进行预测
new_text = "home_address"
predictions = loaded_model.predict([new_text])
print(predictions)
