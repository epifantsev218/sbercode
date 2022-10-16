package sbercode

allow[msg] {
	res := input.url
    regex.match(".+\\.apps\\.sbc-okd\\.pcbltools\\.ru", res.easy)
	msg := "[OK] заполнен URL для HTTP-соединения"
}

deny[msg] {
	res := input.url
    not regex.match(".+\\.apps\\.sbc-okd\\.pcbltools\\.ru", res.easy)
	msg := "[ERROR] не заполнен URL для HTTP-соединения"
}

allow[msg] {
	res := input.curl
    res.easy=="200"
	msg := "[OK] успешная проверка HTTP-соединения"
}

error[msg] {
	res := input.curl
    res.easy!="200"
	msg := concat(" ", ["[ERROR] ошибка при проверке HTTP соединения. Код ошибки",res.easy])
}

error[msg] {
	msg := input.error
}