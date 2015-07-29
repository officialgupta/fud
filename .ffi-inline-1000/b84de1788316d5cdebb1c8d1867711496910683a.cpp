#include <tesseract/strngs.h>

#line 38 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			void free (void* pointer) {
				free(pointer);
			}
		 }

#line 44 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			void free_array_of_char (char* pointer) {
				delete [] pointer;
			}
		 }

#line 50 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			void free_array_of_int (int* pointer) {
				delete [] pointer;
			}
		 }

#line 56 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			STRING* create_string (void) {
				return new STRING();
			}
		 }

#line 62 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			void destroy_string (STRING* value) {
				delete value;
			}
		 }

#line 68 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			int string_length (STRING* value) {
				return value->length();
			}
		 }

#line 74 "/usr/local/rvm/gems/ruby-2.2.1/gems/tesseract-ocr-0.1.8/lib/tesseract/c.rb"
extern "C" {
			const char* string_content (STRING* value) {
				return value->string();
			}
		 }
