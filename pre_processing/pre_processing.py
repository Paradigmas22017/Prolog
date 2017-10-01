import os
import codecs
from time import time
import re
import nltk
nltk.download('stopwords')
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer

path = '../dataset'
data = [['corpus', 'label']]
sucess_parse = 0
fail_parse = 0
start_time = time()

for root, dirs, files in os.walk(path):
    for file in files:
        try:
            file_path = os.path.join(root, file)
            f = open(file_path, 'r', encoding='ISO-8859-1')

            # Leitura das informações
            head, content = f.read().split('\n', 1)
            content = re.sub('[^a-zA-Z]', ' ', content)
            content = content.lower()
            content = content.split()
            ps = PorterStemmer()
            content = [ps.stem(word) for word in content if not word in set(stopwords.words('english'))]
            content = ' '.join(content)

            print(content)
