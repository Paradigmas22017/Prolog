
from time import time
from sklearn.datasets import load_files

t0 = time()
dataset = load_files(container_path='../dataset', shuffle=True)
print('Import Time: %0.3fs' % (time() - t0))
X, y = dataset.data, dataset.target
print('X size: %d\ny size: %d' % (len(X), len(y)))


from sklearn.feature_extraction.text import CountVectorizer

vectorizer_bow = CountVectorizer(max_features=100000) # Retiramos cerca de 2000 features
t0 = time()
X_bow = vectorizer_bow.fit_transform(X)
print('Bag of words time: %0.3fs' % (time() - t0))


from sklearn.feature_extraction.text import TfidfVectorizer

vectorizer_tfidf = TfidfVectorizer(min_df=1,
                                   max_df=0.7,
                                   ngram_range=(1,2), # N-Gram
                                   norm='l2',
                                   lowercase=False,
                                   max_features=1340000 # Retiramos certa de 4000 features
                                  )
t0 = time()
X_tfidf = vectorizer_tfidf.fit_transform(X)
print('TF-IDF time: %0.3fs' % (time() - t0))

from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.feature_extraction.text import HashingVectorizer
from sklearn.pipeline import make_pipeline

hasher = HashingVectorizer(stop_words='english',
                           alternate_sign=False,
                           norm=None,
                           binary=False,
                           n_features=1040000
                          )
vectorizer = make_pipeline(hasher, TfidfTransformer())
t0 = time()
X_hs = vectorizer.fit_transform(X)
print('Hashing + TF-IDF time: %0.3fs' % (time() - t0))




from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, classification_report

X_train_bw, X_test_bw, y_train_bw, y_test_bw = train_test_split(X_bow, y, test_size=0.20)
X_train_tf, X_test_tf, y_train_tf, y_test_tf = train_test_split(X_tfidf, y, test_size=0.20)



import numpy as np
from sklearn.model_selection import cross_validate
from sklearn.metrics import make_scorer, recall_score

from sklearn.naive_bayes import MultinomialNB
clf_nb = MultinomialNB()

from sklearn.linear_model import SGDClassifier
clf_sgd = SGDClassifier(alpha=.0001, max_iter=50, penalty="l2")

from sklearn.svm import LinearSVC
clf_svm = LinearSVC(penalty='l2', dual=True, tol=1e-3)

from sklearn.linear_model import PassiveAggressiveClassifier
clf_pa = PassiveAggressiveClassifier(max_iter=50)




classifiers = {
    'NaiveBayesMultinomial': clf_nb,
    'SGDClassifier': clf_sgd,
    'SVMLinear': clf_svm,
    'PassiveAgressive': clf_pa
}
X_s = {
    'BagOfWords': X_bow,
    'TF-IDF': X_tfidf,
    'Hashing+TFIDF': X_hs
}
scoring = {'prec_macro': 'precision_macro',
           'rec_micro': make_scorer(recall_score, average='macro')}
t0 = time()
for X in X_s:
    print (X)
    for clf in classifiers:
        scores = cross_validate(classifiers[clf], X_s[X], y, scoring=scoring,
                                cv=10, return_train_score=True)
        print ('\t {} - {}'.format(clf, np.mean(scores['test_prec_macro'])))

print('Execution time %0.3fs' % (time() - t0))
