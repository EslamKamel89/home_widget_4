// ignore_for_file: public_member_api_docs, sort_constructors_first

class DateInfoEntity {
  String? id;
  String? fmStart;
  String? fmEnd;
  String? hgStart;
  String? hgEnd;
  String? hnStart;
  String? hnEnd;
  String? oldHgHijriStart;
  String? oldHgHijriEnd;
  String? oldFmHijriStart;
  String? oldFmHijriEnd;
  DateInfoEntity({
    this.id,
    this.fmStart,
    this.fmEnd,
    this.hgStart,
    this.hgEnd,
    this.hnStart,
    this.hnEnd,
    this.oldHgHijriStart,
    this.oldHgHijriEnd,
    this.oldFmHijriStart,
    this.oldFmHijriEnd,
  });

  @override
  String toString() {
    return 'DateInfoEntity(id: $id, fmStart: $fmStart, fmEnd: $fmEnd, hgStart: $hgStart, hgEnd: $hgEnd, hnStart: $hnStart, hnEnd: $hnEnd, oldHgHijriStart: $oldHgHijriStart, oldHgHijriEnd: $oldHgHijriEnd, oldFmHijriStart: $oldFmHijriStart, oldFmHijriEnd: $oldFmHijriEnd)';
  }
}
