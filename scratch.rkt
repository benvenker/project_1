;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname scratch) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH  200)
(define HEIGHT  20)

(define TEXT-SIZE  18)
(define TEXT-COLOR "BLACK")

(define CURSOR (rectangle 1 20 "solid" "red"))

(define MTS (empty-scene WIDTH HEIGHT))

(define-struct editor (txt cp))
;; Editor is (make-editor String Natural)
;; interp. the current text (txt) and cursor position (cp) using a 0-based index

(define ED1 (make-editor ""       0)) ; empty
(define ED2 (make-editor "abcdef" 0)) ; cursor at beginning as in |abcdef
(define ED3 (make-editor "abcdef" 3)) ; cursor in middle of text as in abc|def
(define ED4 (make-editor "abcdef" 6)) ; cursor at end as in abcdef|

(define (main e)
  (big-bang e
            (to-draw    render)                  ; Editor -> Image
            (on-key     handle-key)))            ; Editor KeyEvent -> Editor

(define (render e)
  (overlay/align "left"
                 "middle" 
                 (beside (editor-txt e)
                         CURSOR
                         (editor-cp e))))

;; Editor -> Image
;; create the substring to the left of the cursor
(check-expect (2nd-half-string (make-editor "abcdef" 3)) "abc")
(check-expect (2nd-half-string (make-editor "abcdef" 6)) "abcdef")

;(define (2nd-half-string e))  ;stub
(define (2nd-half-string e)
  (text (substring (editor-txt e) (editor-cp e)) TEXT-SIZE TEXT-COLOR))


#;
(define (handle-key e key)
  (cond [(key=? key "left")        (... e)]
        [(key=? key "right")       (... e)]
        [(key=? key "\b")          (... e)]        
        [(= (string-length key) 1) (... e)]
        [else (... e)]))