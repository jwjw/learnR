rmdir _book /S /Q
rscript publish.R
cd _book
git init 
git commit --allow-empty -m "Update built gitbook" 
git checkout -b gh-pages 
git add . 
git commit -am "Update built gitbook"
git push https://github.com/renkun-ken/learnR.git gh-pages --force
git checkout master
git branch -D gh-pages