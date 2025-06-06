## GITHUB
<!-- Init a GIT workspace -->
```bash
cd project01_SLAM
git init
git add .
git status
git commit -m "MySetup for Ubuntu 18.04"
git branch -M ubuntu-18.04
git branch
```

<!-- Connect to GitHub and push data -->
```bash
git remote add origin git@github.com:ngCuyentam11286/MySetup.git
git push -u origin ubuntu-18.04
```

<!-- Update and push data -->
```bash
git add .
git commit -m "Update_V1 06.06.2025"
git push -u origin ubuntu-18.04
```