import firebase_admin
from firebase_admin import credentials, storage, firestore

class Database:
    def __init__(self):
        #Replace the projectID eg.
        self.bucket_name = 'aiproject-c4d80.appspot.com'
        # self.bucket_name = '<projectID>.appspot.com'

        # You need to download the serviceaccount.json
        self.fb_cred = r"C:\Users\G47God\Desktop\aiproject-c4d80-firebase-adminsdk-gwu4p-9894b17b4c.json"
        cred = credentials.Certificate(self.fb_cred)
        firebase_admin.initialize_app(cred,
                                      {'storageBucket': self.bucket_name})
        self.db = firestore.client()  # this connects to our Firestore database
        self.collection_name = 'foreign_video'

    def exists_on_cloud(self, filename):
        bucket = storage.bucket()
        blob = bucket.blob(filename)
        if blob.exists():
            return blob.public_url
        else:
            return False

    def upload_file(self, firebase_path, local_path):
        url = self.exists_on_cloud(firebase_path)
        if not url:
            bucket = storage.bucket()
            blob = bucket.blob(firebase_path)
            blob.upload_from_filename(local_path)
            print('This file is uploaded to cloud.')
            blob.make_public()
            url = blob.public_url
        return url
    
    def add_words(self, video_title, data: dict):
        collection = self.db.collection(self.collection_name)  # opens collection_name
        doc = collection.document(video_title)  # specifies the  document
        doc.set(data, merge=True)