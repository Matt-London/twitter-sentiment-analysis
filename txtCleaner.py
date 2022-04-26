"""
Quickly clears out all non-utf8 characters and other forbidden words
and characters

"""

import sys
import os

# A word containing these will be completely removed
forbidden_words = ["http", "<U"]

# A word containing these characters will be stripped
forbidden_chars = ["@", "#", "\""]

def main():
  # Drop non utf8 characters
  fileName = sys.argv[1]
  os.system("iconv -f utf-8 -t utf-8 -c {} -o {}".format(fileName, "utf8_" + fileName))
  
  fileName = "utf8_" + fileName
  
  file = open(fileName, "r")
  dest = open("stripped_" + fileName, "a+")
  
  # Loop through each line in the file
  for line in file:
    # split the line into words
    words = line.split(" ")
    
    newLine = []
    
    # Loop through each word
    for word in words:
      skip = False
      
      # Check for forbidden_characters
      for for_char in forbidden_chars:
        word.replace(for_char, "")
        
      # Now look for contents that drop the whole word
      for for_word in forbidden_words:
        if for_word in word:
          skip = True
          break
      
      # Now write the word into the new line
      if skip:
        continue
      
      newLine.append(word)
    
    # Now write the line
    dest.write(" ".join(newLine))
    

  # Close both the files
  dest.close()
  file.close()
  
if __name__ == "__main__":
  main()
