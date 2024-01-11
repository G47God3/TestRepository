import os



from transcript import Transcript
from video_engine import VideoEngine

# Two unrelated videos have 91% error which is good means code works

# initialize flask model
transcript = Transcript()
v_engine = VideoEngine(transcript=transcript)


# receiving request + storing into variables


# getting filename
video_file = r"C:\Users\G47God\Desktop\TestRepository\Volodymyr Zelenskyy： The 2023 60 Minutes Interview [Z8qC2tVkGeU].mp4"
# _____altering filename ....

# Saving with new filename

v_engine.generate_subtitle_word_definition(video_file)

# remove/delete filepath
os.remove(video_file)
