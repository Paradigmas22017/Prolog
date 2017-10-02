import os
import codecs
from time import time
import re

path = '../dataset'
data = [['corpus', 'label']]
sucess_parse = 0
fail_parse = 0
start_time = time()

print('\n\tThis could take a while\n')
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
            content = ' '.join(content)

            row = []
            row.append(content)
            label = root.split(os.path.sep)[-1]
            row.append(label)
            data.append(row)
            # print('Succes: ', file_path)  # Arquivos que foram adicionado com sucesso
            sucess_parse += 1

        except Exception as e:
            print('Failed at: ', file_path)
            print('Error', e)
            fail_parse += 1
            pass


import csv

out_file_name = './email_content.csv'
with open(out_file_name, 'w') as out_file:
    writer = csv.writer(out_file)
    writer.writerows(data)
    print('File parsed. Created file %s!' % out_file_name)

duration = time() - start_time
print('Finished with %0.3fs. Parsed %d documents. Error in %d documents.' % (duration, sucess_parse, fail_parse))
