@echo off

echo ====================  
echo Sync Vault  
echo ====================  
  
rem robocopy "C:\Users\allen\Obsidian Vault\Allen Vault" "C:\Users\allen\quartz\content" /MIR /XD "C:\Users\allen\Obsidian Vault\Allen Vault\.obsidian"
robocopy "C:\Users\allen\Obsidian Vault\Allen Vault" "C:\cloude\project\quartz\content" /MIR /XD "C:\Users\allen\Obsidian Vault\Allen Vault\.obsidian"

echo ====================  
echo Quartz Build  
echo ====================  
  
cd /d C:\cloude\project\quartz 
  
call npx quartz build

echo ====================  
echo Git Push  
echo ====================

git add .

git commit -m "update"

git push

pause   