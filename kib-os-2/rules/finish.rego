package sbercode

allow[msg] {
	res := input.results[_]
	res.httpbin_retcode == "200"
	msg := "[OK] простое подключение настроено корректно"
}

deny[msg] {
	res := input.results[_]
	res.httpbin_retcode != "200"
	msg := "[ERROR] сервис недоступен по ссылке http://${EASY_URL}"
}

error[msg] {
	msg := input.error
}
