terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

/* resource "aws_iam_user" "user" {
  count = length(var.usernames)
  name = var.usernames[count.index]
 }
 */ 

resource "aws_iam_user" "user" {
  for_each= var.usernames
  name = each.value
 }

/* output "uppercase_countries" {
      value = [for user_name in var.usernames : upper(user_name)]
    }
*/