DECLARE
   p_person_rec               hz_party_v2pub.person_rec_type;
   x_cust_account_id      NUMBER;
   x_account_number    VARCHAR2 (2000);
   x_party_id                  NUMBER;
   x_party_number         VARCHAR2 (2000);
   x_profile_id                NUMBER;
   x_return_status           VARCHAR2 (2000);
   x_msg_count                NUMBER;
   x_msg_data                  VARCHAR2 (2000);
   l_msg_index_out          NUMBER;
   l_error_message          VARCHAR2 (100);
BEGIN
    p_person_rec.person_first_name :='&person_first_name';
    p_person_rec.person_last_name :='&person_last_name';
    p_person_rec.created_by_module :='TCA_V2_API';
    hz_party_v2pub.create_person( p_init_msg_list => 'T',
                                  p_person_rec    => p_person_rec,
                                  x_party_id => x_party_id,     
                                  x_party_number => x_party_number,
                                  x_profile_id => x_profile_id,   
                                  x_return_status => x_return_status, 
                                  x_msg_count  => x_msg_count,   
                                  x_msg_data => x_msg_data);
  IF x_return_status = fnd_api.g_ret_sts_success THEN
     dbms_output.put_line('output information');
     dbms_output.put_line('x_party_id:' || x_party_id);
     dbms_output.put_line('x_party_number:' || x_party_number);
     dbms_output.put_line('x_profile_id:' || x_profile_id);
   
      IF x_msg_count > 0
      THEN
         FOR i IN 1 .. x_msg_count
         LOOP
            apps.fnd_msg_pub.get (p_msg_index          => i,
                                  p_encoded            => fnd_api.g_false,
                                  p_data               => x_msg_data,
                                  p_msg_index_out      => l_msg_index_out
                                 );
         END LOOP;

         IF l_error_message IS NULL
         THEN
            l_error_message := SUBSTR (x_msg_data, 1, 250);
         ELSE
            l_error_message :=
                       l_error_message || ' /' || SUBSTR (x_msg_data, 1, 250);
         END IF;

         DBMS_OUTPUT.put_line ('*****************************************');
         DBMS_OUTPUT.put_line ('API Error : ' || l_error_message);
         DBMS_OUTPUT.put_line ('*****************************************');
      END IF;
   END IF;
END;      
