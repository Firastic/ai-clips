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
   (test(< ?angle 89))
   =>
	(assert (segitigaLancip yes))
)

(defrule isTriangleTumpul
	(segitiga yes)
   (point ?n ?x ?y ?angle ?l)
   (test(> ?angle 91))
   =>
	(assert (segitigaTumpul yes))
)

(defrule isTriangleSiku
	(segitiga yes)
   (point ?n ?x ?y ?angle ?l)
   (test (> ?angle 89))
   (test (> ?angle 91))
   =>
	(assert (segitigaSiku yes))
)

(defrule isTriangleKaki
	(segitiga yes)
   (point 1 ?x ?y ?angle1 ?l1)
   (point 2 ?x ?y ?angle2 ?l2)
   (point 3 ?x ?y ?angle3 ?l3)
   (not (segitigaSamaSisi yes))
   (test(or (>= ?angle1 (- ?angle2 1)) (<= ?angle1 (+ ?angle2 1))))
   (test(or (>= ?angle1 (- ?angle3 1)) (<= ?angle1 (+ ?angle3 1))))
   (test(or (>= ?angle3 (- ?angle2 1)) (<= ?angle3 (+ ?angle2 1))))
   =>
	(assert (segitigaSamaKaki yes))
)

(defrule isTriangleSisi
	(segitiga yes)
   (point 1 ?x ?y ?angle1 ?l1)
   (point 2 ?x ?y ?angle2 ?l2)
   (point 3 ?x ?y ?angle3 ?l3)
   (test(> ?angle1 59))
   (test(< ?angle1 61))
   (test(> ?angle2 59))
   (test(< ?angle2 61))
   (test(> ?angle3 59))
   (test(< ?angle3 61))
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
   (point ?n2 ?x ?y ?angle2 ?l2)
   (test(eq ?l1 ?l2))
   (point ?n3 ?x ?y ?angle3 ?l3)
   (point ?n4 ?x ?y ?angle4 ?l4)
   (test(eq ?l3 ?l4))
   (test(neq ?l1 ?l3))
   (test(or (>= ?angle1 (- ?angle2 1)) (<= ?angle1 (+ ?angle2 1))))
   (test(or (>= ?angle1 (- ?angle3 1)) (<= ?angle1 (+ ?angle3 1))))
   (test(or (>= ?angle1 (- ?angle4 1)) (<= ?angle1 (+ ?angle4 1))))
   (test(or (>= ?angle3 (- ?angle2 1)) (<= ?angle3 (+ ?angle2 1))))
   (test(or (>= ?angle4 (- ?angle2 1)) (<= ?angle4 (+ ?angle2 1))))
   (test(or (>= ?angle3 (- ?angle4 1)) (<= ?angle3 (+ ?angle4 1))))

   =>
   (assert (segiEmpatGenjang yes))
)

(defrule segiEmpatBeraturan
   (segiEmpatGenjang yes)
   (point ?n1 ?x ?y ?angle1 ?l1)
   (point ?n2 ?x ?y ?angle2 ?l2)
   (point ?n3 ?x ?y ?angle3 ?l3)
   (point ?n4 ?x ?y ?angle4 ?l4)
   (test (eq ?l1 ?l2))
   (test (eq ?l1 ?l3))
   (test (eq ?l1 ?l4))
   (test (eq ?l2 ?l3))
   (test (eq ?l2 ?l4))
   (test (eq ?l3 ?l4))
   (test(or (>= ?angle1 (- ?angle2 1)) (<= ?angle1 (+ ?angle2 1))))
   (test(or (>= ?angle1 (- ?angle3 1)) (<= ?angle1 (+ ?angle3 1))))
   (test(or (>= ?angle1 (- ?angle4 1)) (<= ?angle1 (+ ?angle4 1))))
   (test(or (>= ?angle3 (- ?angle2 1)) (<= ?angle3 (+ ?angle2 1))))
   (test(or (>= ?angle4 (- ?angle2 1)) (<= ?angle4 (+ ?angle2 1))))
   (test(or (>= ?angle3 (- ?angle4 1)) (<= ?angle3 (+ ?angle4 1))))
   =>
   (assert (segiEmpatBeraturan yes))
)

(defrule segiEmpatLayang
   (segiEmpatBeraturan yes)
   (point ?n1 ?x ?y ?angle1 ?l1)
   (point ?n2 ?x ?y ?angle2 ?l2)
   (point ?n ?x ?y ?angle3 ?l3)
   (test(or (>= ?angle1 (- ?angle2 1)) (<= ?angle1 (+ ?angle2 1))))
   (test(or (>= ?angle3 89) (<= ?angle3 91)))
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
   (test(or (>= ?angle1 (- ?angle2 1)) (<= ?angle1 (+ ?angle2 1))))
   =>
   (assert (trapesiumKaki yes))
)

(defrule trapesiumKanan
   (trapesium yes)
   (point ?p1 ?x1 ?y1 ?angle1 ?l1)
   (point ?p2 ?x2 ?y2 ?angle2 ?l2)
   (point ?p3 ?x3 ?y3 ?angle ?l3)
   (test(or (>= ?angle1 89) (<= ?angle1 91)))
   (test(or (>= ?angle2 89) (<= ?angle2 91)))
   (test(neq ?p1 ?p2))
   (test(neq ?p1 ?p3))
   (test(neq ?p3 ?p2))
   (test(> ?x1 ?x3))
   =>
   (assert (trapesiumKanan yes))
)

(defrule trapesiumKiri
   (point ?p1 ?x1 ?y1 ?angle1 ?l1)
   (point ?p2 ?x2 ?y2 ?angle2 ?l2)
   (point ?p3 ?x3 ?y3 ?angle ?l3)
   (test(or (>= ?angle1 89) (<= ?angle1 91)))
   (test(or (>= ?angle2 89) (<= ?angle2 91)))
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
   (point 2 ?x ?y ?angle2 ?l2)
   (point 3 ?x ?y ?angle3 ?l3)
   (point 4 ?x ?y ?angle4 ?l4)
   (point 5 ?x ?y ?angle5 ?l5)
   (test(or (>= ?l1 (- ?l2 1)) (<= ?l1 (+ ?l2 1))))
   (test(or (>= ?l1 (- ?l3 1)) (<= ?l1 (+ ?l3 1))))
   (test(or (>= ?l1 (- ?l4 1)) (<= ?l1 (+ ?l4 1))))
   (test(or (>= ?l1 (- ?l5 1)) (<= ?l1 (+ ?l5 1))))
   (test(or (>= ?l2 (- ?l3 1)) (<= ?l2 (+ ?l3 1))))
   (test(or (>= ?l2 (- ?l4 1)) (<= ?l2 (+ ?l4 1))))
   (test(or (>= ?l2 (- ?l5 1)) (<= ?l2 (+ ?l5 1))))
   (test(or (>= ?l3 (- ?l4 1)) (<= ?l3 (+ ?l4 1))))
   (test(or (>= ?l3 (- ?l5 1)) (<= ?l3 (+ ?l5 1))))
   (test(or (>= ?l4 (- ?l5 1)) (<= ?l4 (+ ?l5 1))))
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
   (point 2 ?x ?y ?angle2 ?l2)
   (point 3 ?x ?y ?angle3 ?l3)
   (point 4 ?x ?y ?angle4 ?l4)
   (point 5 ?x ?y ?angle5 ?l5)
   (point 6 ?x ?y ?angle6 ?l6)
   (test(or (>= ?l1 (- ?l2 1)) (<= ?l1 (+ ?l2 1))))
   (test(or (>= ?l1 (- ?l3 1)) (<= ?l1 (+ ?l3 1))))
   (test(or (>= ?l1 (- ?l4 1)) (<= ?l1 (+ ?l4 1))))
   (test(or (>= ?l1 (- ?l5 1)) (<= ?l1 (+ ?l5 1))))
   (test(or (>= ?l1 (- ?l6 1)) (<= ?l1 (+ ?l6 1))))
   (test(or (>= ?l2 (- ?l3 1)) (<= ?l2 (+ ?l3 1))))
   (test(or (>= ?l2 (- ?l4 1)) (<= ?l2 (+ ?l4 1))))
   (test(or (>= ?l2 (- ?l5 1)) (<= ?l2 (+ ?l5 1))))
   (test(or (>= ?l2 (- ?l6 1)) (<= ?l2 (+ ?l6 1))))
   (test(or (>= ?l3 (- ?l4 1)) (<= ?l3 (+ ?l4 1))))
   (test(or (>= ?l3 (- ?l5 1)) (<= ?l3 (+ ?l5 1))))
   (test(or (>= ?l3 (- ?l6 1)) (<= ?l3 (+ ?l6 1))))
   (test(or (>= ?l4 (- ?l5 1)) (<= ?l4 (+ ?l5 1))))
   (test(or (>= ?l4 (- ?l6 1)) (<= ?l4 (+ ?l6 1))))
   (test(or (>= ?l5 (- ?l6 1)) (<= ?l5 (+ ?l6 1))))
   =>
   (assert (segiEnamSisi yes))
)