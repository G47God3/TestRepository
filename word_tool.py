import nltk
from PyDictionary import PyDictionary
from nltk import pos_tag, WordNetLemmatizer
from nltk.tokenize import word_tokenize

# Download the required resources (run this once)
nltk.download('punkt')
nltk.download('averaged_perceptron_tagger')
nltk.download('wordnet')
def extract_word_set(text, part_of_speech, discard_words):
    words = word_tokenize(text)
    tags = pos_tag(words)
    print(tags)
    lemmatizer = WordNetLemmatizer()
    word_set = {lemmatizer.lemmatize(word.lower(), 'v') for word, tag in tags if
                tag.startswith(part_of_speech) and "'" not in word and not word[0].isupper()}
    word_set = {word for word in word_set if
                word not in discard_words}
    print(word_set)
    return word_set

def get_meaning(word):
    dictionary = PyDictionary()
    word_meaning = dictionary.meaning(word)
    # for key, value in word_meaning.items():
    #     print(key, value)
    return word_meaning

def get_verbs(text, db, video_title):
    print('Extracting verbs')
    discard_words = {'volodymyr', 'zelensky', 'be', 'have', 'go', 'do', 'get', 'think'}
    
    verbs = extract_word_set(text=text, part_of_speech='VB', discard_words=discard_words)
    # print(verbs)
    verb_definition = {}
  
    for v in verbs:
        meaning = get_meaning(v)

        verb_definition[v] = meaning
        data = {'words': {v: meaning}}

        db.add_words(video_title=video_title, data=data)
 
    # print(verb_definition)
    return verbs

