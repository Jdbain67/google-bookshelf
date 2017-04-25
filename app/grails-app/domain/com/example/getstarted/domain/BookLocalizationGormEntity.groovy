package com.example.getstarted.domain

import com.example.getstarted.objects.BookLocalization
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
class BookLocalizationGormEntity implements BookLocalization {
    String title
    String description
    String languageCode
    static belongsTo = [book: BookGormEntity]

    static constraints = {
        title nullable: false
        description nullable: true
    }

    static mapping = {
        table 'book_localization'
        description type: 'text'
    }
}
