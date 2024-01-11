import os.path
from pathlib import Path

import moviepy.editor as mp
from moviepy.video.tools.subtitles import SubtitlesClip


def extractAudio(video_file):
    final_audio_file = f'{Path(video_file).stem}.mp3'
    if not os.path.exists(final_audio_file):
        clip = mp.VideoFileClip(video_file)
        clip.audio.write_audiofile(final_audio_file)
    return final_audio_file

def millisec_2_sec(time):
    return int(time) / 1000


def add_subtitle(subs, video_path):
  
    
    output_path = f'{Path(video_path).stem}.mp4'
    if not os.path.exists(output_path):
        video = mp.VideoFileClip(video_path)
        video_width = video.w  # Width of the video in pixels
        generator = lambda txt: mp.TextClip(txt, font='Arial', fontsize=30, color='white', bg_color='black',stroke_width=3,
                                    method='caption', size=(video_width - 50, None))

        subtitles = SubtitlesClip(subs, generator)

        result = mp.CompositeVideoClip([video, subtitles.set_pos(('center', 'bottom'))])

        result.write_videofile(output_path, fps=video.fps, temp_audiofile="video.m4a", remove_temp=True,
                           codec="libx264", audio_codec="aac")
    return output_path


def get_subs_text(sentences):
    subs = []
    text = ''
    for sentence in sentences:
        start = millisec_2_sec(sentence['start'])
        end = millisec_2_sec(sentence['end'])
        subs.append(((start, end), sentence['text']))
        text += f"{sentence['text']} "
    return subs, text