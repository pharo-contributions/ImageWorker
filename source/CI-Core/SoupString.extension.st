Extension { #name : #SoupString }

{ #category : #'*CI-Core' }
SoupString >> rescuedText [

	| map result |
	map := OrderedCollection newFrom: {
				'&amp;quot;' -> '"'.
				'&amp;apos;' -> ''''.
				'&amp;lt;' -> '<'.
				'&amp;gt;' ->'>'.
				'&quot;' -> '"'.
				'&apos;' -> ''''.
				'&lt;' -> '<'.
				'&gt;' ->'>'.
				'&amp;' -> '&'}.
				
	result := contents.
	map do: [:pair | result := result copyReplaceAll: pair key with: pair value ].
	^ result
]
