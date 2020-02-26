//半角英数字のみ 英数字含む 7文字以上
jQuery.validator.addMethod("alphanum", function(value, element) {
	return this.optional(element) || /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{2,}$/i.test(value);
	}, "半角英数字でのみ入力してください（英字と数字の両方を含めて設定してください）"
);

//全角カタカナのみ
jQuery.validator.addMethod("katakana", function(value, element) {
	return this.optional(element) || /^([ァ-ヶー]+)$/.test(value);
	}, "全角カタカナを入力してください"
);

//郵便番号（例:012-3456）
jQuery.validator.addMethod("postnum", function(value, element) {
	return this.optional(element) || /^\d{3}-?\d{4}$/.test(value);
	}, "郵便番号を入力してください（例:123-4567）"
);