function Install-ChefDk {
  choco install chefdk
  mkdir "$home/.chef"
}
