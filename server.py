import os

from flask import Flask, request

from transcript import Transcript
from video_engine import VideoEngine

# Two unrelated videos have 91% error which is good means code works

# initialize flask model
app = Flask(__name__)
transcript = Transcript()
v_engine = VideoEngine(transcript=transcript)


@app.route("/")
def hello():
    return "Foreign Language Server"


# map specific url
app.config['UPLOAD_EXTENSIONS'] = ['.mpeg', 'mp4', 'mov', 'webm']



@app.route('/edit_video', methods=['GET', 'POST'])

def edit_video():
    # receiving request + storing into variables
    uploaded_video1 = request.files.getlist("video")[0]

    # getting filename
    video_file = uploaded_video1.filename
    # _____altering filename ....
    if video_file != '':
        # Saving with new filename
        uploaded_video1.save(video_file)
        v_engine.generate_subtitle_word_definition(video_file)

    # remove/delete filepath
    os.remove(video_file)


# run server locally
app.run(host='0.0.0.0')