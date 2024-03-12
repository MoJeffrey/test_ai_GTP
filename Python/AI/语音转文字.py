from openai import OpenAI
assistant_id = 'asst_n7fedrDASDr9IVuJmt38QDjK'
api_key = ''
client = OpenAI(api_key=api_key)

audio_file= open("test1.m4a", "rb")
transcript = client.audio.translations.create(
  model="whisper-1",
  file=audio_file,
  response_format="text"
)

print(transcript)