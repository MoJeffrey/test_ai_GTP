from modelscope import AutoModelForCausalLM, AutoTokenizer
from modelscope import GenerationConfig

class AI:
    system = """
     <|system|>:正常聊天就行
     """
    history = None

    def __init__(self):
        self.tokenizer = AutoTokenizer.from_pretrained("/mnt/e/root/autodl-tmp/msa-7b/damo/ModelScope-Agent-7B",
                                                  revision='v1.0.0', trust_remote_code=True)
        self.model = AutoModelForCausalLM.from_pretrained("/mnt/e/root/autodl-tmp/msa-7b/damo/ModelScope-Agent-7B",
                                                     revision='v1.0.0', device_map="auto", trust_remote_code=True,
                                                     fp16=True).eval()
        self.model.generation_config = GenerationConfig.from_pretrained(
            "/mnt/e/root/autodl-tmp/msa-7b/damo/ModelScope-Agent-7B", revision='v1.0.0',
            trust_remote_code=True)  # 可指定不同的生成长度、top_p等相关超参

    def send_msg(self, msg):
        print("\n你：", msg)
        response, self.history = self.model.chat(self.tokenizer, "你好", history=self.history, system=self.system)
        print("\nAI：", response)


if __name__ == "__main__":
    ai = AI()
    while True:
        msg = input("你：")
        ai.send_msg(msg)
