import pandas as pd

# 从CSV文件加载数据
df = pd.read_csv('TrainingSet.csv')

# 查看前几行数据
print(df['text'].tolist())
print(df['label'].tolist())
