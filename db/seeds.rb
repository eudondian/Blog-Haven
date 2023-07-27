# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(
    name: 'Esther Haven',
    bio: 'Story of Esther\'s life ...',
    photo: 'https://i.pravatar.cc/300',
    email: 'miles@king.him',
    password: 'password',
  )
  second_user = User.create(name: 'Lilly', photo: 'https://i.pravatar.cc/300', bio: 'Teacher from Poland.')
  first_user = User.create(name: 'Tom', photo: 'https://i.pravatar.cc/300', bio: 'Teacher from Mexico.')
  first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
  second_post = Post.create(author: first_user, title: 'Hello world', text: 'This is my first post')
  third_post = Post.create(author: first_user, title: 'Hey there', text: 'This is my first post')
  fourth_post = Post.create(author: first_user, title: 'Hey there', text: 'This is my first post')
  fifth_post = Post.create(author: second_user, title: 'Hey there', text: 'This is my first post')
  Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' )
  Comment.create(post: first_post, author: first_user, text: 'Hi Lilly!' )
  Comment.create(post: first_post, author: user, text: 'Hi guys!' )