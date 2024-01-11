import moviepy.editor as mp
from moviepy.video.tools.subtitles import SubtitlesClip
from moviepy.editor import *;
from pathlib import Path
from transcript import Transcript
import video_tool as vt
from database import Database
from word_tool import get_verbs
from chatGPT import get_quiz

def make_dir(path):
    if not os.path.exists(path):
        os.mkdir(path)
class VideoEngine: 
    def __init__(self, transcript):
        self.transcript = transcript
        self.db = Database()

    def _extract_sentences(self, video_file):
        audio_file = vt.extractAudio(video_file)
        sentences = self.transcript.get_sentences(audio_file)
        os.remove(audio_file)
        return sentences

    def generate_subtitle_word_definition(self, video_path):
        video_title = Path(video_path).stem
        sentences = self._extract_sentences(video_path)
        subs, text = vt.get_subs_text(sentences)
        output_video = vt.add_subtitle(subs, video_path)
        url = self.db.upload_file(firebase_path=f'foreign_video/{output_video}', local_path=output_video)
        verbs = get_verbs(text, self.db, video_title)
        quiz = get_quiz(str(verbs))
        data = {'url': url, 'transcript': text, 'quiz': quiz}
        self.db.add_words(video_title=video_title, data=data)


#video_file = r'C:\Users\Gary\Youtube\Volodymyr Zelenskyy： The 2023 60 Minutes Interview [Z8qC2tVkGeU].webm'
