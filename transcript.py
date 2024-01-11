from time import sleep

import requests


class Transcript:

    def __init__(self):
        self.__audio_file = ''

    # make a function to pass the mp3 to the upload endpoint
    def __read_file(self, filename):
        with open(filename, 'rb') as _file:
            while True:
                data = _file.read(5242880)
                if not data:
                    break
                yield data

    def __get_speech_info(self):
        # store global constants
        # You need to create an account in AssemblyAI API. https://www.assemblyai.com/

        # Add your assembly AI key here
        auth_key = '2e5f1d0fdb8246eaa41f16b051f9d1b4'

        headers = {
            "authorization": auth_key,
            "content-type": "application/json"
        }
        transcript_endpoint = "https://api.assemblyai.com/v2/transcript"
        upload_endpoint = 'https://api.assemblyai.com/v2/upload'
        # upload our audio file
        upload_response = requests.post(
            upload_endpoint,
            headers=headers, data=self.__read_file(self.__audio_file)
        )
        print('Audio file uploaded')

        # send a request to transcribe the audio file
        transcript_request = {'audio_url': upload_response.json()['upload_url'], }
        transcript_response = requests.post(transcript_endpoint, json=transcript_request, headers=headers)
        print('Transcription Requested')

        # set up polling
        polling_response = requests.get(f"{transcript_endpoint}/{transcript_response.json()['id']}",
                                        headers=headers)

        while polling_response.json()['status'] != 'completed':
            # if our status isn’t complete, sleep and then poll again
            sleep(20)
            polling_response = requests.get(transcript_endpoint + "/" + transcript_response.json()['id'],
                                            headers=headers)
            print("File is", polling_response.json()['status'])

        # self.__transcript = polling_response.json()
        paragraph_response = requests.get(f"{transcript_endpoint}/{transcript_response.json()['id']}/sentences",
                                          headers=headers)
        paragraph_response = paragraph_response.json()
        self.__transcript = paragraph_response
        print(self.__transcript)

    def get_sentences(self, audio_file):
        if audio_file != self.__audio_file:
            self.__audio_file = audio_file
            self.__get_speech_info()

        return self.__transcript['sentences']