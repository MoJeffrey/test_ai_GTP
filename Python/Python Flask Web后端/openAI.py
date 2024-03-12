import os
import time

from openai import OpenAI


class AI:
    assistant_id = 'asst_n7fedrDASDr9IVuJmt38QDjK'
    # 替换key
    api_key = ''
    client = OpenAI(api_key=api_key)
    thread = None
    assistants = None

    def __init__(self, threads_id: str = None):
        os.environ["OPENAI_API_KEY"] = AI.api_key
        if threads_id is None:
            self.thread = self.client.beta.threads.create()
            print(f"thread_id: {self.thread.id}")
        else:
            self.thread = self.client.beta.threads.retrieve(threads_id)

        self.assistants = self.client.beta.assistants.retrieve(self.assistant_id)

    def wait_on_run(self, run):
        while run.status == "queued" or run.status == "in_progress":
            run = self.client.beta.threads.runs.retrieve(
                thread_id=self.thread.id,
                run_id=run.id,
            )
            time.sleep(0.5)
        return run

    def send_msg(self, msg: str):
        message = self.client.beta.threads.messages.create(
            thread_id=self.thread.id,
            role="user",
            content=msg
        )

        run = self.client.beta.threads.runs.create(
            thread_id=self.thread.id,
            assistant_id=self.assistant_id)

        self.wait_on_run(run)

        messages = self.client.beta.threads.messages.list(
            thread_id=self.thread.id, order="asc", after=message.id
        )

        return messages.data[0].content[0].text.value

    def get_history_msg(self):
        messages = self.client.beta.threads.messages.list(
            thread_id=self.thread.id, order="asc"
        )

        message_list = []
        for message in messages:
            data = {"text": message.content[0].text.value, "timestamp": message.created_at}
            message_list.append(data)

        return message_list


if __name__ == '__main__':
    a = AI("thread_4qW3lKt5RpNadOWNTpjsA6u1")
    # m = a.send_msg("我是小飞")
    # print(m)
    a.get_history_msg()