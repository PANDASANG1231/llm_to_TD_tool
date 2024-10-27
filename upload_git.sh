echo Hello world

git_pusher() {
    # Ensure a commit message and remote URL are provided
    if [ "$#" -lt 2 ]; then
        echo "Usage: git_pusher <commit_message> <remote_repo_url>"
        return 1
    fi

    # Arguments
    commit_message=$1
    remote_repo_url=$2

    # Initialize git repository if not already initialized
    if [ ! -d .git ]; then
        echo "Initializing git repository..."
        git init
    else
        echo "Git repository already initialized."
    fi

    # Add all files
    echo "Adding files..."
    git add .

    # Commit changes
    echo "Committing with message: '$commit_message'"
    git commit -m "$commit_message"

    # Add remote repository if it doesn't exist
    if git remote | grep -q "origin"; then
        echo "Remote 'origin' already exists."
        git remote remove origin
        git remote add origin $remote_repo_url
    else
        echo "Adding remote repository: $remote_repo_url"
        git remote add origin $remote_repo_url
    fi

    # Push changes to remote repository
    echo "Pushing changes to remote repository..."
    git push -u origin master
}


folders=$(ls -d */)
echo "$folders"

# Loop through each directory
for folder in $folders; do
    echo "Entering $folder"
    cd "$folder"              # cd into the folder
    git_pusher "Init_messsage" "https://github.com/PANDASANG1231/${folder%/}.git"
    # echo "https://github.com/PANDASANG1231/${folder%/}.git"
    echo "Now inside $(pwd)"  # Print current directory (optional)
    cd ..                     # cd back to the parent directory
    echo "Exited $folder"
done