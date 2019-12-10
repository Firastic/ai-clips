;;;;;;;;;;;;;;;;;;;
;;/* DEFTEMPLATE */
;;;;;;;;;;;;;;;;;;;

(deftemplate shape
   (slot totalPoint)
   (slot segitiga)
   (multislot point))

;;;;;;;;;;;;;;;;;;;
;;/* DEFFACTS      */
;;;;;;;;;;;;;;;;;;;

;;****************
;;* DEFFUNCTIONS *
;;****************

;;;;;;;;;;;;;;;;;;;
;;/* DEFRULE */
;;;;;;;;;;;;;;;;;;;

(defrule startup
	=>
	(printout t "Welcome to shape detector!" crlf)
)

;;/* ----------- SEGITIGA -----------*/

(defrule isTriangle "Segitiga"
	(totalPoint 3)
   =>
	(assert (segitiga yes))
)

(defrule isTriangleLancip
	(segitiga yes)
   (point ?n ?x ?y ?angle ?l)
   (test(< ?angle 90))
   =>
	(assert (segitigaLancip yes))
)

(defrule isTriangleTumpul
	(segitiga yes)
   (point ?n ?x ?y ?angle ?l)
   (test(> ?angle 90))
   =>
	(assert (segitigaTumpul yes))
)

(defrule isTriangleSiku
	(segitiga yes)
   (point ?n ?x ?y 90 ?l)
   =>
	(assert (segitigaSiku yes))
)

(defrule isTriangleKaki
	(segitiga yes)
   (point 1 ?x ?y ?angle1 ?l1)
   (point 2 ?x ?y ?angle2 ?l2)
   (point 3 ?x ?y ?angle3 ?l3)
   (test(or (eq ?angle1 ?angle2) (eq ?angle1 ?angle3)))
   (test(or (eq ?angle1 ?angle2) (eq ?angle3 ?angle2)))
   (test(or (eq ?angle3 ?angle2) (eq ?angle1 ?angle3)))
   (test(neq ?angle1 60))
   (test(neq ?angle2 60))
   (test(neq ?angle3 60))
   =>
	(assert (segitigaSamaKaki yes))
)

(defrule isTriangleSisi
	(segitiga yes)
   (point 1 ?x ?y ?angle1 ?l1)
   (point 2 ?x ?y ?angle2 ?l2)
   (point 3 ?x ?y ?angle3 ?l3)
   (test(neq ?angle1 60))
   (test(neq ?angle2 60))
   (test(neq ?angle3 60))
   =>
	(assert (segitigaSamaSisi yes))
)

(defrule isTriangleKakiLancip
	(segitigaSamaKaki yes)
   (segitigaLancip yes)
   =>
	(assert (segitigaKakiLancip yes))
)

(defrule isTriangleKakiTumpul
	(segitigaSamaKaki yes)
   (segitigaTumpul yes)
   =>
	(assert (segitigaKakiTumpul))
)

(defrule isTriangleKakiSiku
   (segitigaSamaKaki yes)
	(segitigaSiku yes)
   =>
	(assert (segitigaKakiSiku yes))
)

;;/* ----------- SEGIEMPAT -----------*/

(defrule isRectangle
	(totalPoint 4)
   =>
	(assert (segiEmpat yes))
)

(defrule isRectangleGenjang
   (segiEmpat yes)
   (point ?n1 ?x ?y ?angle1 ?l1)
   (point ?n2 ?x ?y ?angle1 ?l2)
   (test(eq ?l1 ?l2))
   (point ?n3 ?x ?y ?angle1 ?l3)
   (point ?n4 ?x ?y ?angle1 ?l4)
   (test(eq ?l3 ?l4))
   (test(neq ?l1 ?l3))
   =>
   (assert (segiEmpatGenjang yes))
)

(defrule segiEmpatBeraturan
   (segiEmpatGenjang yes)
   (point ?n1 ?x ?y ?angle1 ?l1)
   (point ?n2 ?x ?y ?angle1 ?l2)
   (point ?n3 ?x ?y ?angle1 ?l3)
   (point ?n4 ?x ?y ?angle1 ?l4)
   (test (eq ?l1 ?l2))
   (test (eq ?l1 ?l3))
   (test (eq ?l1 ?l4))
   (test (eq ?l2 ?l3))
   (test (eq ?l2 ?l4))
   (test (eq ?l3 ?l4))
   =>
   (assert (segiEmpatBeraturan yes))
)

(defrule segiEmpatLayang
   (segiEmpatBeraturan yes)
   (point ?n1 ?x ?y ?angle1 ?l1)
   (point ?n2 ?x ?y ?angle1 ?l2)
   (point ?n ?x ?y ?angle1 90)
   (test(eq ?l1 ?l2))
   =>
   (assert (segiEmpatLayang yes))
)

(defrule trapesium
   (segiEmpat yes)
   =>
   (assert (trapesium yes))
)

(defrule trapesiumKaki
   (trapesium yes)
   (point ?p1 ?x1 ?y1 ?angle1 ?l1)
   (point ?p2 ?x2 ?y2 ?angle2 ?l2)
   (test(eq ?angle1 ?angle2))
   =>
   (assert (trapesiumKaki yes))
)

(defrule trapesiumKanan
   (trapesium yes)
   (point ?p1 ?x1 ?y1 90 ?l1)
   (point ?p2 ?x2 ?y2 90 ?l2)
   (point ?p3 ?x3 ?y3 ?angle ?l3)
   (test(neq ?p1 ?p2 ?p3))
   (test(> ?x1 ?x3))
   =>
   (assert (trapesiumKanan yes))
)

(defrule trapesiumKiri
   (point ?p1 ?x1 ?y1 90 ?l1)
   (point ?p2 ?x2 ?y2 90 ?l2)
   (point ?p3 ?x3 ?y3 ?angle ?l3)
   (test(neq ?p1 ?p2))
   (test(neq ?p1 ?p3))
   (test(neq ?p3 ?p2))
   (test(< ?x1 ?x3))
   =>
   (assert (trapesiumKiri yes))
)

;;/*---------- SEGILIMA ----------*/

(defrule segiLima
   (totalPoint 5)
   =>
   (assert (segiLima yes))
)

(defrule segiLimaSisi
   (point 1 ?x ?y ?angle1 ?l1)
   (point 2 ?x ?y ?angle1 ?l2)
   (point 3 ?x ?y ?angle1 ?l3)
   (point 4 ?x ?y ?angle1 ?l4)
   (point 5 ?x ?y ?angle1 ?l5)
   (test(eq ?l1 ?l2))
   (test(eq ?l1 ?l3))
   (test(eq ?l1 ?l4))
   (test(eq ?l1 ?l5))
   (test(eq ?l2 ?l3))
   (test(eq ?l2 ?l4))
   (test(eq ?l2 ?l5))
   (test(eq ?l3 ?l4))
   (test(eq ?l3 ?l5))
   (test(eq ?l4 ?l5))
   =>
   (assert (segiLimaSisi yes))
)

;;/*---------- SEGIENAM ----------*/

(defrule segiEnam
   (totalPoint 6)
   =>
   (assert (segiEnam yes))
)

(defrule segiEnamSisi
   (point 1 ?x ?y ?angle1 ?l1)
   (point 2 ?x ?y ?angle1 ?l2)
   (point 3 ?x ?y ?angle1 ?l3)
   (point 4 ?x ?y ?angle1 ?l4)
   (point 5 ?x ?y ?angle1 ?l5)
   (point 6 ?x ?y ?angle1 ?l6)
   (test(eq ?l1 ?l2))
   (test(eq ?l1 ?l3))
   (test(eq ?l1 ?l4))
   (test(eq ?l1 ?l5))
   (test(eq ?l1 ?l6))
   (test(eq ?l2 ?l3))
   (test(eq ?l2 ?l4))
   (test(eq ?l2 ?l5))
   (test(eq ?l2 ?l6))
   (test(eq ?l3 ?l4))
   (test(eq ?l3 ?l5))
   (test(eq ?l3 ?l6))
   (test(eq ?l4 ?l5))
   (test(eq ?l4 ?l6))
   (test(eq ?l5 ?l6))
   =>
   (assert (segiEnamSisi yes))
)