package com.citadel.backend.dao.Niu;

import com.citadel.backend.entity.NiuApplicationDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NiuApplicationDocumentDao extends JpaRepository<NiuApplicationDocument, Long> {

}
